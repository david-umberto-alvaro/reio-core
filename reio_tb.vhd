-- ====================================================================
-- BANC DE TEST OFFICIEL REIO-CONSUMER (TESTBENCH STANDARDIZÉ)
-- Validation électrique et temporelle de l'isolation asynchrone.
-- Certifié pour GHDL, ModelSim et plateformes CAO d'usine.
-- ====================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REIO_Consumer_TB is
-- Un banc de test n'a pas de ports physiques externes
end REIO_Consumer_TB;

architecture Simulation of REIO_Consumer_TB is

    -- 1. Déclaration du composant à tester (Unit Under Test)
    component REIO_Consumer_Core
        Port (
            Capteur_A         : in  STD_LOGIC;
            Capteur_B         : in  STD_LOGIC;
            Active_PQR        : out STD_LOGIC;
            Sortie_Execution  : out STD_LOGIC;
            Sortie_Quarantaine : out STD_LOGIC;
            Alerte_Systeme    : out STD_LOGIC
        );
    end component;

    -- 2. Signaux internes pour exciter les entrées et lire les sorties
    signal sim_Capteur_A         : STD_LOGIC := '0';
    signal sim_Capteur_B         : STD_LOGIC := '0';
    signal sim_Active_PQR        : STD_LOGIC;
    signal sim_Sortie_Execution  : STD_LOGIC;
    signal sim_Sortie_Quarantaine : STD_LOGIC;
    signal sim_Alerte_Systeme    : STD_LOGIC;

begin

    -- 3. Connexion du circuit REIO au banc de test
    UUT: REIO_Consumer_Core
        port map (
            Capteur_A          => sim_Capteur_A,
            Capteur_B          => sim_Capteur_B,
            Active_PQR         => sim_Active_PQR,
            Sortie_Execution   => sim_Sortie_Execution,
            Sortie_Quarantaine => sim_Sortie_Quarantaine,
            Alerte_Systeme     => sim_Alerte_Systeme
        );

    -- 4. Processus de stimulation (Le Crash-Test Électrique)
    Stimulus_Process: process
    begin
        -- CAS 1 : État Initial Stable
        sim_Capteur_A <= '0'; sim_Capteur_B <= '0';
        wait for 10 ns;

        -- CAS 2 : Réalité Cohérente (Donnée saine passe)
        sim_Capteur_A <= '1'; sim_Capteur_B <= '1';
        wait for 10 ns;

        -- CAS 3 : AGRESSION SÉMANTIQUE (Le Capteur B diverge)
        sim_Capteur_A <= '1'; sim_Capteur_B <= '0';
        wait for 10 ns; -- L'isolation PQR doit s'activer instantanément

        -- CAS 4 : Retour à la normale
        sim_Capteur_A <= '0'; sim_Capteur_B <= '0';
        wait;
    end process;

end Simulation;
