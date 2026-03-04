import sys
from pathlib import Path

DENY_PATTERNS = [
    "0.0.0.0/0",              # overly broad rules often show up in plans
    "publicly_accessible = true",  # RDS/SQL public exposure smell
]

def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: validate_plan.py <plan.txt>")
        return 2

    plan_path = Path(sys.argv[1])
    if not plan_path.exists():
        print(f"Plan file not found: {plan_path}")
        return 2

    text = plan_path.read_text(errors="ignore")

    violations = [p for p in DENY_PATTERNS if p in text]
    if violations:
        print("❌ Plan policy violations found:")
        for v in violations:
            print(f" - Contains forbidden pattern: {v}")
        return 1

    print("✅ Plan policy checks passed.")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())