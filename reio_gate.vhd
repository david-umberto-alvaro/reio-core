-- REIO-GATE-001 : Implémentation matérielle de la porte p-AND REIO
-- Conforme au Standard REIO-RFC-003 / Licence GNU GPLv3
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REIO_Gate_pAND is
    Port ( 
        Ligne_A : in  STD_LOGIC;  -- Signal d'entrée A
        Ligne_B : in  STD_LOGIC;  -- Signal d'entrée B
        Sortie_S : out STD_LOGIC; -- Canal d'Exécution Nominal
        Ligne_Q  : out STD_LOGIC  -- Canal de Quarantaine Paracohérent
    );
end REIO_Gate_pAND;

architecture Behavioral of REIO_Gate_pAND is
begin
    process(Ligne_A, Ligne_B)
    begin
        -- Cas Nominal 0-0 ou 1-1
        if (Ligne_A = '0' and Ligne_B = '0') then
            Sortie_S <= '0';
            Ligne_Q  <= '0';
        elsif (Ligne_A = '1' and Ligne_B = '1') then
            Sortie_S <= '1';
            Ligne_Q  <= '0';
        -- Cas d'Anomalie/Contradiction (1-0 ou 0-1) : Confinement REIO V3
        else
            Sortie_S <= '0'; -- Blocage immédiat de l'ordre d'exécution
            Ligne_Q  <= '1'; -- Déviation physique du courant vers la quarantaine
        end if;
    end process;
end Behavioral;
