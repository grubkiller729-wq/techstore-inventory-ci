import sys

issues = []
with open("app.py", "r") as f:
    content = f.read()

if "DB_PASSWORD =" in content and "os.getenv" not in content:
    issues.append("Credencial guardada en código duro encontrada en app.py")

if "debug=True" in content:
    issues.append("Modo debug activado en app.py")

if issues:
    print("Se encontraron fallos de seguridad:")
    for issue in issues:
        print(" -", issue)
    sys.exit(1)
else:
    print("Chequeo de seguridad de la app aprobado.")
    sys.exit(0)