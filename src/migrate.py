import os
import pyodbc
from dotenv import load_dotenv

load_dotenv()

def build_connection_string():
    driver = os.getenv("DB_DRIVER")
    server = os.getenv("DB_SERVER")
    port = os.getenv("DB_PORT")
    database = os.getenv("DB_NAME")
    user = os.getenv("DB_USER")
    password = os.getenv("DB_PASSWORD")

    # אם עובדים עם FreeTDS (מקומי)
    if driver == "FreeTDS":
        tds_version = os.getenv("DB_TDS_VERSION", "7.4")
        return (
            f"DRIVER={{{driver}}};"
            f"SERVER={server};"
            f"PORT={port};"
            f"DATABASE={database};"
            f"UID={user};"
            f"PWD={password};"
            f"TDS_Version={tds_version};"
        )

    # אחרת (CI – ODBC Driver 18)
    return (
        f"DRIVER={{{driver}}};"
        f"SERVER={server};"
        f"DATABASE={database};"
        f"UID={user};"
        f"PWD={password};"
        f"Encrypt=no;"
        f"TrustServerCertificate=yes;"
    )


def run_migrations():
    conn_str = build_connection_string()

    conn = pyodbc.connect(conn_str)
    conn.autocommit = True
    cursor = conn.cursor()

    script_path = os.path.join(os.path.dirname(__file__), "..", "db_scripts")
    scripts = sorted([f for f in os.listdir(script_path) if f.endswith(".sql")])

    for script in scripts:
        print(f"Executing {script}...")
        with open(os.path.join(script_path, script), "r", encoding="utf-8") as f:
            cursor.execute(f.read())

    conn.close()
    print("✅ Migration completed successfully winn!")


if __name__ == "__main__":
    run_migrations()
