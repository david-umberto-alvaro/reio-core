-- ====================================================================
-- PROTOCOLE REIO V5 (STANDARD RFC-005) - ARBITRE DE ROUTAGE RÉSEAU
-- Implémentation du Bus Paracohérent Récursif par Consensus Majoritaire.
-- Détection et coupure physique des lignes injectées ou défaillantes.
-- Auteur: David Umberto Alvaro / Licence GNU GPLv3
-- ====================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REIO_Bus_V5 is
    Port (
        Clk             : in  STD_LOGIC; -- Horloge de synchronisation réseau
        Reset           : in  STD_LOGIC; -- Réinitialisation déterministe du nœud
        -- Signaux entrants des trois circuits indépendants (V4)
        Bus_In_A        : in  STD_LOGIC; 
        Bus_In_B        : in  STD_LOGIC;
        Bus_In_C        : in  STD_LOGIC;
        -- Canaux sortants et alertes matérielles de sécurité
        Network_Out     : out STD_LOGIC; -- Canal de communication réseau épuré
        Isolate_Line_A  : out STD_LOGIC; -- Commande de coupure de la ligne A
        Isolate_Line_B  : out STD_LOGIC; -- Commande de coupure de la ligne B
        Isolate_Line_C  : out STD_LOGIC; -- Commande de coupure de la ligne C
        Network_Alert   : out STD_LOGIC  -- Drapeau d'attaque par injection réseau
    );
end REIO_Bus_V5;

architecture Behavioral of REIO_Bus_V5 is
begin

    -- PROCESSUS DÉTERMINISTE DE VOTE ET DE COUPE-CIRCUIT RÉSEAU
    Process_Network_Consensus: process(Clk, Reset)
    begin
        if Reset = '1' then
            Network_Out    <= '0';
            Isolate_Line_A <= '0';
            Isolate_Line_B <= '0';
            Isolate_Line_C <= '0';
            Network_Alert  <= '0';
        elsif rising_edge(Clk) then
            
            -- Analyse de la convergence des circuits (Logique Majoritaire)
            if (Bus_In_A = Bus_In_B) and (Bus_In_A = Bus_In_C) then
                -- Cas 1 : Cohérence absolue du réseau
                Network_Out    <= Bus_In_A;
                Isolate_Line_A <= '0';
                Isolate_Line_B <= '0';
                Isolate_Line_C <= '0';
                Network_Alert  <= '0';
                
            elsif (Bus_In_A = Bus_In_B) and (Bus_In_A /= Bus_In_C) then
                -- Cas 2 : Le Circuit C diverge de la réalité convergente de A et B
                Network_Out    <= Bus_In_A; -- Propagation de la vérité
                Isolate_Line_A <= '0';
                Isolate_Line_B <= '0';
                Isolate_Line_C <= '1'; -- Isolement électrique immédiat du fil C
                Network_Alert  <= '1'; -- Alerte générale injection activée
                
            elsif (Bus_In_A = Bus_In_C) and (Bus_In_A /= Bus_In_B) then
                -- Cas 3 : Le Circuit B diverge de la réalité convergente de A et C
                Network_Out    <= Bus_In_A;
                Isolate_Line_A <= '0';
                Isolate_Line_B <= '1'; -- Isolement électrique immédiat du fil B
                Isolate_Line_C <= '0';
                Network_Alert  <= '1';
                
            elsif (Bus_In_B = Bus_In_C) and (Bus_In_B /= Bus_In_A) then
                -- Cas 4 : Le Circuit A diverge de la réalité convergente de B et C
                Network_Out    <= Bus_In_B;
                Isolate_Line_A <= '1'; -- Isolement électrique immédiat du fil A (Le pirate)
                Isolate_Line_B <= '0';
                Isolate_Line_C <= '0';
                Network_Alert  <= '1';
                
            else
                -- Cas 5 : Chaos total ou désynchronisation complète (Divergence 3 voies)
                Network_Out    <= '0';  -- Coupure immédiate du flux par sécurité
                Isolate_Line_A <= '1';
                Isolate_Line_B <= '1';
                Isolate_Line_C <= '1';
                Network_Alert  <= '1';
            end if;
            
        end if;
    end process;

end Behavioral;
