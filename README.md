# REIO-CORE (Version 3.0.0 / Standard RFC-003)

[Pour la version française, faites défiler la page vers le bas / French version below]

## 📌 About the Project
Modern computing faces a major structural crisis. Classical logical architectures and statistical Artificial Intelligences run on empty abstractions (Platonic idealism), causing data hallucinations or fatal logical crashes (principle of explosion) whenever they encounter real-world noise and contradictions.

**REIO (Optimized Instrumented Experimental Realism)** definitively solves this vulnerability. It is the first **meta-logical immunization protocol for autonomous systems**. This engineering framework forces machines to strictly index their premises on certified physical signals, topologically isolate sensor anomalies in a sealed paraconsistent zone, and safely rewrite their core premises under an irreversible cryptographic lock.

The scientific priority and theoretical foundations of this international standard have been officially published and time-stamped on Zenodo:
👉 **[Read the official REIO-RFC-003 specification on Zenodo](https://zenodo.org)**

---

## 🚀 Specific Proof: Cyber-Physical Crash-Test Simulation

This repository contains the `reio_demo.py` script, which simulates a cyber-physical data injection attack on a critical industrial infrastructure (reactor cooling system).

The code demonstrates in real-time:
1. How classical computing is deceived, leading to the physical destruction of the plant.
2. How the **REIO V3** engine neutralizes the hack, isolates the anomaly, rewrites its internal state, and maintains system safety.

---

## 🛠️ How to run the demonstration?

1. Open your terminal.
2. Run the proof script with zero external dependencies (pure Python):
   ```bash
   python reio_demo.py
   ```
---

## 🔌 Hardware Architecture: The REIO-SPU-101 Chip Specification

To transition from abstract computing to physical immunization, a REIO processor abandons the classic Von Neumann architecture. It implements a **Semantic Processing Unit (SPU)** where paraconsistent logic is engraved at the silicon level.

### 1. [REIO-HW-A2] Certified Input Pins (CIP)
Every data input bus is physically coupled with an asymmetric cryptographic decoder wired into the silicon. If an input signal lands on a pin without a valid hardware authentication token from a certified physical sensor, the logic gate remains open to the electrical ground. The unauthorized data is physically annihilated and never reaches the CPU registers.

### 2. [REIO-HW-A4] Paraconsistent Quarantine Register (PQR)
The processor features two physically isolated register zones separated by potential barriers. 
* **Active Execution Register (AER)**: Handles nominal, verified operations.
* **Paraconsistent Quarantine Register (PQR)**: Stores out-of-bound anomalies. The hardware is structurally designed to hold conflicting states (such as `1 AND 0`) inside the PQR without triggering a hardware interrupt, a kernel panic, or an electrical short-circuit. The rest of the chip continues executing the AER seamlessly.

### 3. [REIO-HW-A5] Recursive Axiom Switching Engine (Meta-R1)
A hardware clock cycle counter is directly linked to the Quarantine Register (PQR). If an anomaly persists for more than $N$ consecutive clock cycles (excluding thermal noise below $\epsilon$), the Meta-R1 operator triggers a programming voltage on the internal non-volatile memory (EEPROM/Flash). The obsolete nominal axiom in the AER is instantly overwritten with the new physical constant measured in real-time.

### 4. [REIO-HW-A6] ZK-ASIC Cryptographic Shield
An Application-Specific Integrated Circuit (ASIC) dedicated to Zero-Knowledge Proofs is engraved alongside the logical core. Every time an axiom rewrite occurs via the Meta-R1 engine, the ZK-ASIC bakes a mathematical proof of legitimacy. The resulting cryptographic hash is burned into an array of One-Time Programmable (OTP) hardware fuses. Once blown, the logical history of the chip becomes physically unalterable.

### 5. [REIO-HW-V4] SPU-102: Hardware Triangulation & Temporal Inertia

To eliminate single-point-of-failure risks from compromised or corrupted sensors, the SPU-102 architecture introduces the **Material Triangulation Axiom (MTA)**. The chip inputs a triplet of orthogonal hardware sources ($T_1, T_2, T_3$). A majority-voting synthesis process isolates any deviating pin by grounding its trace, allowing the execution to proceed seamlessly on the remaining operational sensors. Additionally, a **Temporal Sliding Register (TSR)** defines the structural thickness of time ($\tau$). Micro-delays below $\tau$ are filtered as passive noise, while discrepancies exceeding $\tau$ activate the Paraconsistent Quarantine Register without inducing software latch-up.

### 6. [REIO-HW-V5] RPB-201: Paraconsistent Bus Arbiter

The RPB-201 module scales the REIO protocol from a standalone chip to a distributed network topology through the **Paraconsistent Bus Router**. When multi-node systems communicate over a shared physical cable, the routing node cross-checks incoming frames against the collective logical convergence of the other active, verified circuits. If a rogue data injection or a semantic denial-of-service attack strikes a single channel, the arbiter triggers a discrete physical open-circuit on that specific trace. The malicious node is isolated, preventing network bus saturation, while the rest of the cluster maintains nominal data flow at full speed.

### 7. [REIO-HW-V6] CIP-V6: Orthogonal Impedance Isolation Pin

To neutralize synchronous multi-node spoofing attacks executed via external cabling, the CIP-V6 architecture shifts verification to the electrodynamic layer. The pin measures incoming rise times and impedance signatures. If the physical trait deviates from the factory-sealed silicon reference (Signature = 0), the hardware instantly connects the pin directly to the ground plane (Broche_Masse = 1). The malicious external signal is physically shorted out to 0 Volts before reaching the majority-voting modules, isolating the attack at the hardware boundary.

### 8. [REIO-HW-V6] PSR-001: Passive Semantic Resonance Filter

To counteract entropy-exhaustion or ghost-injection attacks without draining device battery reserves, the PSR-001 layer deploys **Passive Semantic Resonance**. Integrated directly at the boundary of the CIP-V6 pin, this unpowered physical stage filters incoming inputs based on frequency convergence. High-frequency chaotic transients and asynchronous noise pulses are inherently suppressed by the micro-inductive and capacitive inertia of the hardware fabric, causing them to collapse and dissipate as micro-heat. Only structural signals matching the nominal, stabilized timing of official sensors can traverse the passive substrate, eliminating active switching overhead during adversarial flooding.

### 9. [REIO-STD-V6] AMBA APB Wrapper: Industrial Silicon Interconnect

To achieve universal industry standardization, the REIO core is encapsulated within an **AMBA APB (Advanced Peripheral Bus)** hardware wrapper (`reio_apb_wrapper.vhd`). This standard interface translates raw paraconsistent signals into fully compliant ARM architectures. It manages active-low system resets (`PRESETn`) through deterministic internal inversion and enforces strict address-phase execution (`PSEL` and `PENABLE`). Housed at base address `0x00`, a dedicated status register routes the core nominal execution path, quarantine line status, and sensor fault alerts directly to the host processor data bus (`PRDATA`), delivering drop-in semantic immunity for standard IoT and automotive microcontrollers.

---
---
# REIO-CORE (Version 3.0.0 / Standard RFC-003)

## 📌 À propos du projet
L'informatique moderne est confrontée à une crise structurelle majeure. Les architectures logiques classiques et les Intelligences Artificielles statistiques tournent à vide (idéalisme platonicien), provoquant des hallucinations de données ou des pannes logiques fatales (principe d'explosion) dès qu'elles sont confrontées au bruit et aux contradictions du monde physique.

**REIO (Réalisme Expérimental Instrumenté Optimisé)** résout définitivement cette vulnérabilité. Il s'agit du premier **protocole méta-logique d'immunisation pour systèmes autonomes**. Ce cadre d'ingénierie contraint les machines à indexer strictement leurs prémisses sur le signal physique certifié, à isoler topologiquement les anomalies de mesure dans une zone paracohérente étanche, et à réécrire leurs axiomes de départ sous verrou cryptographique irréversible.

L'antériorité et les fondements théoriques de ce standard scientifique international ont été officiellement publiés et horodatés sur Zenodo :
👉 **[Consulter la publication officielle REIO-RFC-003 sur Zenodo](https://zenodo.org)**

---

## 🚀 Preuve Spécifique : Simulation de Crash-Test Industriel

Ce dépôt contient le script `reio_demo.py` qui simule une attaque cyber-physique par injection de fausses données sur une infrastructure critique (système de refroidissement d'un réacteur). 

Le code démontre en temps réel :
1. Comment l'informatique classique est trompée et conduit à la destruction physique de l'usine.
2. Comment le moteur **REIO V3** neutralise le piratage, applique le confinement de l'anomalie, réécrit ses règles et maintient la sécurité du système.

---

## 🛠️ Comment exécuter la démonstration ?

1. Placez-vous dans votre terminal de commande.
2. Lancez le script de preuve sans aucune dépendance externe (Python pur) :
   ```bash
   python reio_demo.py
   ```
   ---

## 🔌 Architecture Matérielle : Spécifications de la Puce REIO-SPU-101

Pour passer de l'informatique abstraite à l'immunisation physique, un processeur REIO abandonne l'architecture classique de Von Neumann au profit d'une **Unité de Traitement Sémantique (SPU)** où la logique paracohérente est gravée dans le silicium.

### 1. [REIO-HW-A2] Broches d'Entrée Certifiées (CIP)
Chaque bus d'entrée est couplé au niveau du silicium avec un décodeur cryptographique asymétrique câblé. Si un signal se présente sur une broche sans jeton d'authentification matériel valide provenant d'un capteur certifié, la porte logique d'entrée reste ouverte à la masse électrique. La donnée non autorisée est détruite et n'atteint jamais les registres.

### 2. [REIO-HW-A4] Registre de Quarantaine Paracohérent (PQR)
Le processeur dispose de deux zones de registres physiquement étanches, séparées par des barrières de potentiel.
* **Active Execution Register (AER)** : Gère le comportement nominal de l'automate.
* **Paraconsistent Quarantine Register (PQR)** : Stocke les anomalies hors-seuils. L'existence d'une contradiction logique (ex: `1 AND 0`) dans le registre PQR ne provoque aucun court-circuit ni aucune interruption matérielle (`Hardware Panic`). Le reste de la puce s'exécute de manière transparente.

### 3. [REIO-HW-A5] Moteur de Commutation d'Axiomes (Méta-R1)
Un compteur de cycles d'horloge matériel est relié au registre de quarantaine (PQR). Si l'anomalie persiste pendant plus de $N$ cycles consécutifs (excluant le bruit thermique inférieur à $\epsilon$), le méta-opérateur matériel déclenche une tension de programmation sur la grille de mémoire morte (EEPROM/Flash). L'ancien axiome de l'AER est effacé et réécrit instantanément avec la nouvelle constante physique constatée.

### 4. [REIO-HW-A6] Blindage Cryptographique ZK-ASIC
Un circuit intégré dédié (ASIC) aux preuves à divulgation nulle de connaissance (Zero-Knowledge) est gravé à côté du cœur logique. À chaque modification d'axiome par le Méta-R1, le ZK-ASIC calcule la preuve mathématique du changement d'état. Le hash résultant est écrit dans un registre de fusibles physiques (`One-Time Programmable ROM`). Une fois le fusible grillé, le passé logique de la puce est physiquement inaltérable.

### 5. [REIO-HW-V4] SPU-102 : Triangulation Matérielle & Inertie Temporelle

Afin d'éliminer les risques de défaillance unique provenant de capteurs corrompus ou sabotés, l'architecture SPU-102 introduit l'**Axiome de Triangulation Matérielle (MTA)**. La puce traite un triplet de sources matérielles orthogonales ($T_1, T_2, T_3$). Un processus de vote majoritaire isole toute broche divergente en reliant sa trace à la masse électrique, permettant à l'exécution de continuer de manière transparente sur les capteurs sains restants. De plus, un **Registre de Glissement Temporel (TSR)** définit l'épaisseur structurelle du temps ($\tau$). Les micro-décalages inférieurs à $\tau$ sont filtrés comme du bruit passif, tandis que les écarts supérieurs à $\tau$ activent le registre de quarantaine sans provoquer de blocage logiciel.

### 6. [REIO-HW-V5] RPB-201 : Arbitre de Bus Paracohérent

Le module RPB-201 étend le protocole REIO d'une puce autonome à une topologie réseau distribuée via le **Routeur de Bus Paracohérent**. Lorsque des systèmes multi-nœuds communiquent sur un câble physique partagé, le nœud de routage vérifie la cohérence des trames entrantes par rapport à la convergence logique collective des autres circuits actifs et vérifiés. Si une injection de données malveillantes ou une attaque par déni de service sémantique frappe un canal unique, l'arbitre déclenche une ouverture de circuit physique discrète sur cette trace spécifique. Le nœud corrompu est isolé, empêchant la saturation du bus réseau, tandis que le reste de la grappe maintient un flux de données nominal à pleine vitesse.

### 7. [REIO-HW-V6] CIP-V6 : Broche d'Isolation d'Impédance Orthogonale

Afin de neutraliser les attaques par injection synchrone menées via des câbles externes, l'architecture CIP-V6 déplace la vérification sur la couche électrodynamique. La broche mesure les temps de montée et les signatures d'impédance. Si la caractéristique physique dévie du silicium scellé d'usine (Signature = 0), le matériel connecte instantanément la broche directement au plan de masse (Broche_Masse = 1). Le signal externe malveillant est court-circuité à 0 Volt avant d'atteindre les modules de vote majoritaire, isolant l'attaque à la frontière matérielle.

### 8. [REIO-HW-V6] PSR-001 : Filtre de Résonance Sémantique Passive

Afin de contrer les attaques par épuisement d'entropie ou par injections fantômes sans vider les réserves de batterie de l'appareil, la couche PSR-001 déploie un mécanisme de **Résonance Sémantique Passive**. Intégré directement à la frontière de la broche CIP-V6, cet étage physique non alimenté filtre les signaux entrants en fonction de leur convergence fréquentielle. Les impulsions chaotiques à haute frequência et les bruits asynchrones sont intrinsèquement atténués par l'inertie micro-inductive et capacitive du circuit, s'annulant d'eux-mêmes sous forme de micro-chaleur. Seuls les signaux structurels correspondant à la dynamique temporelle stabilisée des capteurs officiels traversent le substrat passif, éliminant toute surconsommation d'énergie active lors d'un bombardement de données.

### 9. [REIO-STD-V6] Enveloppe AMBA APB : Interconnexion Industrielle Silicium

Pour atteindre une standardisation industrielle universelle, le cœur REIO est encapsulé dans une enveloppe matérielle **AMBA APB (Advanced Peripheral Bus)** (`reio_apb_wrapper.vhd`). Cette interface standard traduit les signaux paracohérents bruts pour les rendre compatibles avec les architectures ARM. Elle gère les réinitialisations système actives à l'état bas (`PRESETn`) via une inversion interne déterministe et impose une exécution stricte des phases d'adressage (`PSEL` et `PENABLE`). Situé à l'adresse de base `0x00`, un registre d'état dédié redirige le canal d'exécution nominal, l'état de la ligne de quarantaine et les alertes de défaillance des capteurs directement vers le bus de données du processeur hôte (`PRDATA`), offrant une immunité sémantique immédiate pour les microcontrôleurs standards de l'IoT et de l'automobile.
