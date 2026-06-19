-- ====================================================================
-- PROTOCOLE REIO-CONSUMER (STANDARD RFC-006) - CŒUR BASSE CONSOMMATION
-- Implémentation asynchrone à consommation d'énergie ultra-basse.
-- Isolation sémantique instantanée pour IoT et smartphones.
-- Auteur: David Umberto Alvaro / Licence GNU GPLv3
-- ====================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REIO_Consumer_Core is
    Port (
        -- Entrées directes des capteurs (Sans horloge globale / Pur combinatoire)
        Capteur_A        : in  STD_LOGIC;
        Capteur_B        : in  STD_LOGIC;
        -- Lignes d'alimentation contrôlées (Power Gating)
        Active_PQR       : out STD_LOGIC; -- Active la quarantaine uniquement si nécessaire
        -- Sorties de données et sécurité
        Sortie_Execution : out STD_LOGIC; -- Canal d'exécution nominal des données
        Sortie_Quarantaine: out STD_LOGIC; -- Desvio immédiat de l'erreur sémantique
        Alerte_Systeme   : out STD_LOGIC  -- Alerte de données invalides pour le système
    );
end REIO_Consumer_Core;

architecture Comportement_Asynchrone of REIO_Consumer_Core is
    signal Divergence : STD_LOGIC;
begin

    -- 1. DÉTECTION DE CONTRADICTION PASSIVE (Consommation zéro si les signaux sont identiques)
    Divergence <= Capteur_A xor Capteur_B;

    -- 2. INTERRUPTEUR DE PUISSANCE (Power-Gating dynamique du silicium)
    -- Le circuit de Quarentaine et les alertes ne reçoivent de l'énergie que s'il y a une erreur.
    Active_PQR <= Divergence;

    -- 3. ROUTAGE SÉMANTIQUE ULTRA-RAPIDE (Sans latence de tampons)
    Sortie_Execution   <= Capteur_A and Capteur_B;  -- Passe la donnée si les deux concordent
    Sortie_Quarantaine <= Divergence and Capteur_A; -- Isole la ligne instable
    Alerte_Systeme     <= Divergence;               -- Avertit le processeur central

end Comportement_Asynchrone;
