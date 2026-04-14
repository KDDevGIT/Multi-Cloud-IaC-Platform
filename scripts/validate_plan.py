import sys
from pathlib import Path

DENY_PATTERNS = [
    'cidr_blocks = [\n        "0.0.0.0/0"\n    ]',
    'publicly_accessible    = true',
    'publicly_accessible = true',
]

ALLOW_CONTEXT_HINTS = [
    "aws_route_table",
    "route {",
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

    violations = []

    if "publicly_accessible = true" in text or "publicly_accessible    = true" in text:
        violations.append("Found publicly accessible database configuration.")

    if 'cidr_blocks = ["0.0.0.0/0"]' in text or '"0.0.0.0/0"' in text:
        if "aws_security_group" in text or "azurerm_network_security_group" in text:
            violations.append("Found 0.0.0.0/0 in a security rule context. Review exposure carefully.")

    if violations:
        print("❌ Plan policy violations found:")
        for v in violations:
            print(f" - {v}")
        return 1

    print("✅ Plan policy checks passed.")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())