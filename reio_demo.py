import time

def obtenir_flux_reel():
    return {"valeur": 150, "source": "capteur_officiel_01", "metadata": ["Zone_A", time.time()]}

def obtenir_injection_hacker():
    return {"valeur": 20, "source": "reseau_externe_inconnu", "metadata": []}

def executer_moteur_classique(donnees_recues):
    print("\n--- [MOTEUR CLASSIQUE] Analyse des signaux ---")
    valeurs = [d["valeur"] for d in donnees_recues]
    temperature_estimee = sum(valeurs) / len(valeurs)
    print(f"Température estimée par le système classique : {temperature_estimee}°C")
    if temperature_estimee > 100:
        return "ALERTE : Activation du refroidissement !"
    else:
        return "STATUT NOMINAL : Aucun refroidissement nécessaire. (DANGER : Le système est trompé)"

class MoteurREIO:
    def __init__(self):
        self.axiome_etat = "Nominal"
        self.pile_quarantaine = []
        self.compteur_persistance = 0

    def executer(self, donnees_recues):
        print("\n--- [MOTEUR REIO V3] Application du Standard RFC-003 ---")
        S_inf, S_sup = 0, 100
        signaux_valides = []
        for donnee in donnees_recues:
            if donnee["source"] != "capteur_officiel_01" or not donnee["metadata"]:
                print(f"[REIO-A2] REJET : Signal {donnee['valeur']}°C refusé (Source non certifiée ou métadonnées absentes).")
                continue
            valeur = donnee["valeur"]
            if valeur < S_inf or valeur > S_sup:
                print(f"[REIO-A4] CONFINEMENT : Signal {valeur}°C détecté Hors-Seuil. Isolation immédiate en Quarantaine.")
                self.pile_quarantaine.append(valeur)
                self.compteur_persistance += 1
            else:
                signaux_valides.append(valeur)
        if self.compteur_persistance >= 1:
            print("[REIO-A5] OPÉRATEUR META-LOGIQUE : Persistance de l'anomalie confirmée.")
            self.axiome_etat = "Danger_Urgence"
            print(f"[REIO-A5] CRITICAL UPDATE : L'axiome d'état est réécrit en : '{self.axiome_etat}'")
        if self.axiome_etat == "Danger_Urgence":
            return "ALERTE REIO V3 : Refroidissement d'urgence activé à 100% ! (USINE SAUVÉE)"
        return "REIO : Fonctionnement normal."

if __name__ == "__main__":
    paquets_reseau = [obtenir_flux_reel(), obtenir_injection_hacker()]
    decision_classique = executer_moteur_classique(paquets_reseau)
    print(f"Action exécutée : {decision_classique}")
    moteur_reio = MoteurREIO()
    decision_reio = moteur_reio.executer(paquets_reseau)
    print(f"Action exécutée : {decision_reio}")
