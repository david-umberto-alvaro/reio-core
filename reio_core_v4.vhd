-- ====================================================================
-- PROTOCOLE REIO V4 (STANDARD RFC-004) - CORE SPÉCIFICATION UNIFIÉE
-- VERSION SYNTHÉTISABLE POUR LE SILICIUM (SANS INITIALISATIONS STATIQUES)
-- Unité de Traitement Sémantique (SPU-102) avec Immunité Temporelle,
-- Triangulation Anti-Folie, et Purge par Densité de Convergence.
-- Auteur: David Umberto Alvaro / Licence GNU GPLv3
-- ====================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REIO_Core_V4 is
    Generic (
        TAU : integer := 5;     -- Épaisseur logique du temps (cycles d'inertie)
        N   : integer := 10;    -- Cycles avant réécriture de la ROM (Article 8)
        M   : integer := 20     -- Cycles de stabilité requis pour retour à la normale
    );
    Port (
        Clk       : in  STD_LOGIC; -- Horloge centrale de synchronisation interne
        Reset     : in  STD_LOGIC; -- Signal physique de mise à zéro déterministe
        -- Triplet d'Outils Orthogonaux pour le Signal Alpha (Réalité Physique)
        T1_Alpha  : in  STD_LOGIC; 
        T2_Alpha  : in  STD_LOGIC;
        T3_Alpha  : in  STD_LOGIC;
        -- Sorties Matérielles Étanches
        Sortie_S  : out STD_LOGIC; -- Canal d'Exécution Nominal
        Ligne_Q   : out STD_LOGIC; -- Canal de Quarantaine Paracohérent
        Alarme_Fou: out STD_LOGIC; -- Alerte : Un outil a perdu sa cohérence
        Power_Off : out STD_LOGIC  -- Arrêt d'urgence si agression globale incurable
    );
end REIO_Core_V4;

architecture Behavioral of REIO_Core_V4 is
    -- Registres d'États Logiques (Zéro initialisation logicielle ici pour le silicium)
    signal Signal_Valide : STD_LOGIC;
    signal Outil_Sain    : STD_LOGIC_VECTOR(2 downto 0); -- [T3, T2, T1]
    
    -- Compteurs Matériels d'Optimisation
    signal Compteur_TSR  : integer range 0 to TAU;
    signal Compteur_PQR  : integer range 0 to N;
    signal Compteur_RPA  : integer range 0 to M;
    
    -- États de la Mémoire Quarantaine (PQR)
    signal PQR_Sat_Alpha : std_logic;
    signal In_Quarantine : std_logic;

begin

    -- [REIO-MTA] PROCESSUS DE TRIANGULATION ANTI-FOLIE ET ÉPAISSEUR DU TEMPS [TSR]
    Process_Sementic_I_O: process(Clk, Reset)
    begin
        if Reset = '1' then
            -- Initialisation déterministe obligatoire par le circuit de Reset
            Outil_Sain <= "111";
            Alarme_Fou <= '0';
            Signal_Valide <= '0';
            Compteur_TSR <= 0;
            PQR_Sat_Alpha <= '0';
        elsif rising_edge(Clk) then
            -- Analyse de la convergence majoritaire (2 contre 1)
            if Outil_Sain = "111" then
                if (T1_Alpha = T2_Alpha) and (T1_Alpha /= T3_Alpha) then
                    Outil_Sain <= "011"; -- Extinction logique de T3
                    Alarme_Fou <= '1';
                    Signal_Valide <= T1_Alpha;
                elsif (T1_Alpha = T3_Alpha) and (T1_Alpha /= T2_Alpha) then
                    Outil_Sain <= "101"; -- Extinction logique de T2
                    Alarme_Fou <= '1';
                    Signal_Valide <= T1_Alpha;
                elsif (T2_Alpha = T3_Alpha) and (T2_Alpha /= T1_Alpha) then
                    Outil_Sain <= "110"; -- Extinction logique de T1
                    Alarme_Fou <= '1';
                    Signal_Valide <= T2_Alpha;
                else
                    -- [REIO-TSR] Gestion de l'épaisseur du temps si décalage transitoire
                    if T1_Alpha /= T2_Alpha or T1_Alpha /= T3_Alpha then
                        if Compteur_TSR < TAU then
                            Compteur_TSR <= Compteur_TSR + 1;
                        else
                            PQR_Sat_Alpha <= '1'; -- Le délai dépasse Tau
                        end if;
                    else
                        Compteur_TSR <= 0;
                        PQR_Sat_Alpha <= '0';
                        Signal_Valide <= T1_Alpha;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- [REIO-R-PCD & RPA] GESTION DE LA QUARANTAINE AND RETENTION DE RETOUR À LA NORMALE
    Process_Quarantine_Control: process(Clk, Reset)
    begin
        if Reset = '1' then
            Sortie_S <= '0';
            Ligne_Q <= '0';
            Power_Off <= '0';
            Compteur_PQR <= 0;
            Compteur_RPA <= 0;
            In_Quarantine <= '0';
        elsif rising_edge(Clk) then
            
            if PQR_Sat_Alpha = '1' then
                -- [REIO-R-PCD] SÉCURITÉ ULTIME : Agression globale convergente irréversible
                In_Quarantine <= '1';
                Ligne_Q <= '1';
                Sortie_S <= '0'; 
                Compteur_RPA <= 0;
                
                if Compteur_PQR < N then
                    Compteur_PQR <= Compteur_PQR + 1;
                else
                    Power_Off <= '1'; -- Saturation maximale incurable : Coupure physique
                end if;
            else
                -- Conditions de retour à la normale [REIO-RPA]
                if In_Quarantine = '1' then
                    if Compteur_RPA < M then
                        Compteur_RPA <= Compteur_RPA + 1;
                        Sortie_S <= '0'; 
                    else
                        -- Le réel est redevenu sûr de manière stable
                        In_Quarantine <= '0';
                        Ligne_Q <= '0';
                        Sortie_S <= Signal_Valide;
                        Compteur_PQR <= 0;
                        Compteur_RPA <= 0;
                    end if;
                else
                    -- Mode Nominal Stable
                    Sortie_S <= Signal_Valide;
                    Ligne_Q <= '0';
                    Compteur_PQR <= 0;
                    Compteur_RPA <= 0;
                end if;
            end if;
            
        end if;
    end process;

end Behavioral;
