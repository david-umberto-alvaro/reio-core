-- ====================================================================
-- PROTOCOLE REIO V6 (RFC-006-STD) - ENVELOPE D'INTERCONNEXION AMBA APB
-- Interface matérielle standardisée pour l'intégration de la SPU-102
-- dans les architectures de processeurs ARM et IoT industriels.
-- Auteur: David Umberto Alvaro / Licence GNU GPLv3
-- ====================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REIO_APB_Wrapper is
    Port (
        -- Signaux Systèmes Standard AMBA APB
        PCLK         : in  STD_LOGIC; -- Horloge du bus
        PRESETn      : in  STD_LOGIC; -- Réinitialisation active à l'état bas
        PADDR        : in  STD_LOGIC_VECTOR(31 downto 0); -- Bus d'adresse
        PSEL         : in  STD_LOGIC; -- Sélection du périphérique REIO
        PENABLE      : in  STD_LOGIC; -- Phase d'activation du bus
        PWRITE       : in  STD_LOGIC; -- Direction (1 = Écriture, 0 = Lecture)
        PWDATA       : in  STD_LOGIC_VECTOR(31 downto 0); -- Données d'écriture
        PRDATA       : out STD_LOGIC_VECTOR(31 downto 0); -- Données de lecture
        PREADY       : out STD_LOGIC; -- Signal de synchronisation périphérique
        
        -- Signaux Physiques du Réel REIO (Interconnexion Capteurs)
        T1_Alpha     : in  STD_LOGIC;
        T2_Alpha     : in  STD_LOGIC;
        T3_Alpha     : in  STD_LOGIC;
        Power_Off    : out STD_LOGIC
    );
end REIO_APB_Wrapper;

architecture Behavioral of REIO_APB_Wrapper is

    -- Instanciation des registres internes standardisés de REIO
    signal reg_sortie_s   : STD_LOGIC;
    signal reg_ligne_q    : STD_LOGIC;
    signal reg_alarme_fou : STD_LOGIC;
    signal reset_interne  : STD_LOGIC;

    -- Liaison directe avec votre cœur de calcul unifié V4
    component REIO_Core_V4 is
        Port (
            Clk        : in  STD_LOGIC;
            Reset      : in  STD_LOGIC;
            T1_Alpha   : in  STD_LOGIC;
            T2_Alpha   : in  STD_LOGIC;
            T3_Alpha   : in  STD_LOGIC;
            Sortie_S   : out STD_LOGIC;
            Ligne_Q    : out STD_LOGIC;
            Alarme_Fou : out STD_LOGIC;
            Power_Off  : out STD_LOGIC
        );
    end component;

begin

    -- Inversion du Reset pour correspondre à la norme active à l'état bas de l'APB
    reset_interne <= not PRESETn;
    PREADY        <= '1'; -- Le module REIO répond instantanément à la nanoseconde

    -- Connexion physique du cœur REIO V4 à l'intérieur de l'enveloppe standard
    SPU_102_CORE : REIO_Core_V4
        port map (
            Clk        => PCLK,
            Reset      => reset_interne,
            T1_Alpha   => T1_Alpha,
            T2_Alpha   => T2_Alpha,
            T3_Alpha   => T3_Alpha,
            Sortie_S   => reg_sortie_s,
            Ligne_Q    => reg_ligne_q,
            Alarme_Fou => reg_alarme_fou,
            Power_Off  => Power_Off
        );

    -- PROCESSUS DE LECTURE DU REGISTRE PAR LE PROCESSEUR VIA LE BUS STANDARD
    Process_APB_Read: process(PCLK, PRESETn)
    begin
        if PRESETn = '0' then
            PRDATA <= (others => '0');
        elsif rising_edge(PCLK) then
            if (PSEL = '1' and PENABLE = '1' and PWRITE = '0') then
                -- Le processeur hôte lit l'état de sécurité REIO à l'adresse 0x00
                if PADDR(7 downto 0) = x"00" then
                    PRDATA <= (others => '0');
                    PRDATA(0) <= reg_sortie_s;   -- Bit 0 : Canal Nominal
                    PRDATA(1) <= reg_ligne_q;    -- Bit 1 : Canal Quarantaine
                    PRDATA(2) <= reg_alarme_fou; -- Bit 2 : Alerte Capteur Fou
                else
                    PRDATA <= (others => '0');
                end if;
            end if;
        end if;
    end process;

end Behavioral;
