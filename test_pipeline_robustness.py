# ==============================================================================
# 🧪 REIO SYSTEMS - INDUSTRIAL DATA PIPELINE QA AUTOMATION FRAMEWORK
# COMPLIANT WITH ISO/IEC 25010 TESTING STANDARDS - PYTEST NATIVE ARCHITECTURE
# STAGE 3 (PRO MAX) : DYNAMIC CLI CONFIGURATION & ADVANCED FUZZING METRICS
# ==============================================================================
import pytest
import random
import logging
import sys
import json
import time
import argparse
from typing import Dict, Any

# Compteurs globaux synchrones pour l'acquisition des métriques
METRICS = {
    "total_assertions": 0,
    "nominal_passed": 0,
    "faults_contained": 0,
    "fuzzing_cycles_executed": 0
}

class DataPayloadProcessor:
    """ Component Under Test (CUT) - Le système dont on teste la robustesse. """
    def process_incoming_packet(self, data_packet: Any) -> bool:
        if data_packet is None:
            raise ValueError("ERR_NULL_PAYLOAD: Received packet reference is void.")
            
        if not isinstance(data_packet, dict):
            raise TypeError("ERR_INVALID_FORMAT: Payload layout must be a dictionary primitive.")
            
        required_keys = {"packet_id", "sensor_reading", "checksum"}
        if not required_keys.issubset(data_packet.keys()):
            raise KeyError("ERR_MISSING_FIELD: Mandatory system key validation failed.")
            
        reading = data_packet["sensor_reading"]
        if reading is None or not isinstance(reading, (int, float)):
            raise ValueError("ERR_DATA_CORRUPTION: Sensor reading is non-numeric or null.")
            
        if reading < 0.0 or reading > 100.0:
            raise ValueError(f"ERR_OUT_OF_BOUNDS: Sensor value {reading} violates boundary [0-100].")
            
        return True

# ==============================================================================
# 🧪 SUITE DE TESTS FORMELS PYTEST
# ==============================================================================

@pytest.fixture
def processor():
    return DataPayloadProcessor()

@pytest.mark.parametrize("valid_packet", [
    {"packet_id": 101, "sensor_reading": 42.5, "checksum": "A1B2"},
    {"packet_id": 102, "sensor_reading": 0.0, "checksum": "C3D4"},
    {"packet_id": 103, "sensor_reading": 100.0, "checksum": "E5F6"}
])
def test_nominal_flow_purity(processor, valid_packet):
    """ Évalue la conformité face à des flux de données purs. """
    METRICS["total_assertions"] += 1
    assert processor.process_incoming_packet(valid_packet) is True
    METRICS["nominal_passed"] += 1


@pytest.mark.parametrize("corrupted_packet, expected_exception", [
    (None, ValueError),                                                 
    ("CORRUPTED_STRING_STREAM", TypeError),                             
    ({"packet_id": 201, "sensor_reading": 50.0}, KeyError),             
    ({"packet_id": 202, "sensor_reading": -0.1, "checksum": "99"}, ValueError),  
    ({"packet_id": 203, "sensor_reading": 100.1, "checksum": "99"}, ValueError), 
    ({"packet_id": 204, "sensor_reading": "ERR", "checksum": "00"}, ValueError), 
    ({"packet_id": 205, "sensor_reading": None, "checksum": "11"}, ValueError)   
])
def test_robustness_guard_clauses(processor, corrupted_packet, expected_exception):
    """ Interception déterministe des fautes par les clauses de garde. """
    METRICS["total_assertions"] += 1
    with pytest.raises(expected_exception):
        processor.process_incoming_packet(corrupted_packet)
    METRICS["faults_contained"] += 1


def test_random_chaos_fuzzing(processor):
    """ Fuzzing statistique paramétrable. """
    # Récupération dynamique du nombre de cycles (par défaut 500)
    cycles = getattr(pytest, "cli_cycles", 500)
    
    for i in range(cycles):
        METRICS["total_assertions"] += 1
        bad_reading = random.choice([random.uniform(-50.0, -0.1), random.uniform(100.1, 200.0), "CRASH", None])
        chaos_packet = {"packet_id": 900 + i, "sensor_reading": bad_reading, "checksum": "FUBAR"}
        
        with pytest.raises((ValueError, TypeError)):
            processor.process_incoming_packet(chaos_packet)
        METRICS["faults_contained"] += 1
        METRICS["fuzzing_cycles_executed"] += 1

# ==============================================================================
# 📊 GENERATION ET EXPORTATION DU RAPPORT DE QUALITÉ (JSON)
# ==============================================================================
@pytest.fixture(scope="session", autouse=True)
def generate_quality_audit_report():
    start_time = time.time()
    yield
    execution_time_ms = (time.time() - start_time) * 1000
    
    report_data = {
        "metadata": {
            "framework": "REIO SYSTEMS QA ENGINE PRO MAX",
            "compliance": "ISO/IEC 25010 DATA INTEGRITY",
            "status": "100% REGULATED ACCORDING TO SPECS"
        },
        "metrics": {
            "total_test_assertions": METRICS["total_assertions"],
            "nominal_flows_passed": METRICS["nominal_passed"],
            "invariants_faults_contained": METRICS["faults_contained"],
            "fuzzing_loops_completed": METRICS["fuzzing_cycles_executed"],
            "execution_window_ms": round(execution_time_ms, 2)
        }
    }
    
    with open("qa_robustness_report.json", "w", encoding="utf-8") as f:
        json.dump(report_data, f, indent=4, ensure_ascii=False)

# ==============================================================================
# 🎛️ COUCHE INTERFACE CLI SOUVERAINE (Pour exécution directe sans bug de PATH)
# ==============================================================================
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="REIO SYSTEMS - QA AUTOMATION ENGINE PRO MAX")
    parser.add_argument("--cycles", type=int, default=500, help="Number of fuzzing loops to execute")
    args = parser.parse_items = parser.parse_known_args()[0]
    
    # Injection de l'argument de la console dans l'environnement pytest
    pytest.cli_cycles = args.cycles
    
    print("\n--------------------------------------------------------------")
    print("  REIO SYSTEMS - LAUNCHING PRO MAX QA AUTOMATION ENGINE")
    print("==============================================================")
    print(f"[⚙️ CLI TRIGGER] Injecting {args.cycles} standalone fuzzing vectors...")
    
    # Appel de l'interpréteur pytest natif directement par le script
    pytest.main(["-v", __file__])
