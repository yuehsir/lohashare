#!/usr/bin/env python3
"""
LOHAShare AI Platform New Document Intake Audit Workflow v0.1

Read-only audit script.

This script scans docs/LOHAShare_AI_Platform/ and produces:
1. docops_audit_output/new_document_intake_audit.csv
2. docops_audit_output/new_document_intake_audit_report.md

Safety boundary:
- Does not modify existing repo files
- Does not move files
- Does not delete files
- Does not overwrite Current
- Does not mark documents as Stable
- Does not commit anything
"""

from __future__ import annotations

import csv
import os
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Iterable


ROOT = Path("docs/LOHAShare_AI_Platform")
OUTPUT_DIR = Path("docops_audit_output")
CSV_OUTPUT = OUTPUT_DIR / "new_document_intake_audit.csv"
MD_OUTPUT = OUTPUT_DIR / "new_document_intake_audit_report.md"

ALLOWED_EXTENSIONS = {
    ".md",
    ".docx",
    ".pdf",
    ".txt",
    ".csv",
    ".json",
    ".yml",
    ".yaml",
    ".png",
    ".jpg",
    ".jpeg",
    ".webp",
    ".zip",
    ".ps1",
    ".bat",
}

IGNORE_DIR_NAMES = {
    ".git",
    ".github",
    "__pycache__",
    "node_modules",
    ".venv",
    "venv",
}


@dataclass
class AuditRow:
    path: str
    file_name: str
    extension: str
    size_bytes: int
    top_level_folder: str
    current_or_archive_status: str
    inferred_document_type: str
    suggested_path: str
    needs_human_review: str
    review_reasons: str


def normalize_path(path: Path) -> str:
    return path.as_posix()


def is_ignored_path(path: Path) -> bool:
    return any(part in IGNORE_DIR_NAMES for part in path.parts)


def is_blank_readme(path: Path) -> bool:
    try:
        return path.read_text(encoding="utf-8").strip() == ""
    except UnicodeDecodeError:
        return False


def get_top_level_folder(path: Path) -> str:
    try:
        rel = path.relative_to(ROOT)
    except ValueError:
        return ""
    return rel.parts[0] if rel.parts else ""


def get_current_or_archive_status(path: Path) -> str:
    parts = set(path.parts)
    if "Current" in parts:
        return "Current"
    if "99_Archive" in parts:
        return "99_Archive"
    if "07_Archive" in parts:
        return "Platform Archive"
    return "Unspecified"


def infer_document_type(path: Path) -> str:
    path_str = normalize_path(path).lower()
    name = path.name.lower()
    top = get_top_level_folder(path)

    if top == "00_Main_PRD":
        return "Main PRD"

    if top == "01_Architecture_Governance":
        return "Architecture Governance"

    if top == "02_Modules":
        if any(keyword in path_str for keyword in ["test_log", "test-logs", "poc_test", "decision", "provider_note", "module_spec", "spec"]):
            return "Module Spec / Module Document"
        return "Module Spec / Module Document"

    if top == "04_Support_Knowledge_Base":
        if any(keyword in path_str for keyword in ["incident", "support", "known", "resolved", "debug", "ticket"]):
            return "Support / Incident / Known Issue / Resolved Case"
        return "Support / Incident / Known Issue / Resolved Case"

    if top == "05_Developer_Prompts":
        return "Developer Prompt"

    if top == "06_Release_Notes":
        return "Release Note"

    if top == "07_Archive":
        return "Archive / Package Export"

    if top == "03_SOP_and_QA":
        return "SOP / QA"

    if any(keyword in name for keyword in ["prd", "product_requirements", "main_prd"]):
        return "Main PRD"

    if any(keyword in name for keyword in ["governance", "folder", "structure", "automation", "docops", "handoff", "index"]):
        return "Architecture Governance"

    if any(keyword in name for keyword in ["prompt", "developer_prompt", "lovable", "replit", "claude", "codex", "gemini"]):
        return "Developer Prompt"

    if any(keyword in name for keyword in ["release", "changelog"]):
        return "Release Note"

    if any(keyword in name for keyword in ["support", "incident", "known_issue", "resolved", "debug", "ticket"]):
        return "Support / Incident / Known Issue / Resolved Case"

    if any(keyword in name for keyword in ["module", "spec", "test_log", "decision_record", "provider_note"]):
        return "Module Spec / Module Document"

    if any(keyword in name for keyword in ["archive", "deprecated", "package_export", "zip"]):
        return "Archive / Package Export"

    return "Unknown / Needs Human Review"


def suggest_path(document_type: str, original_path: Path) -> str:
    path_str = normalize_path(original_path)

    if document_type == "Main PRD":
        return "docs/LOHAShare_AI_Platform/00_Main_PRD/Current/"

    if document_type == "Architecture Governance":
        return "docs/LOHAShare_AI_Platform/01_Architecture_Governance/01_Document_Governance/Current/"

    if document_type == "Module Spec / Module Document":
        if "Email_Notification" in path_str:
            return "docs/LOHAShare_AI_Platform/02_Modules/Email_Notification/"
        if "Referral" in path_str:
            return "docs/LOHAShare_AI_Platform/02_Modules/Referral/"
        if "Lead_Console" in path_str or "Nexus" in path_str or "Lead" in original_path.name:
            return "docs/LOHAShare_AI_Platform/02_Modules/Lead_Console/"
        return "docs/LOHAShare_AI_Platform/02_Modules/{Module_Name}/"

    if document_type == "Support / Incident / Known Issue / Resolved Case":
        return "docs/LOHAShare_AI_Platform/04_Support_Knowledge_Base/"

    if document_type == "Developer Prompt":
        if "Email_Notification" in path_str:
            return "docs/LOHAShare_AI_Platform/05_Developer_Prompts/Email_Notification/"
        if "Lead_Console" in path_str or "Nexus" in path_str or "Lead" in original_path.name:
            return "docs/LOHAShare_AI_Platform/05_Developer_Prompts/Lead_Console/Current/"
        return "docs/LOHAShare_AI_Platform/05_Developer_Prompts/{Category}/Current/"

    if document_type == "Release Note":
        return "docs/LOHAShare_AI_Platform/06_Release_Notes/"

    if document_type == "Archive / Package Export":
        return "docs/LOHAShare_AI_Platform/07_Archive/Package_Export/"

    if document_type == "SOP / QA":
        return "docs/LOHAShare_AI_Platform/03_SOP_and_QA/"

    return "Needs Human Review"


def has_matching_md_for_docx(docx_path: Path) -> bool:
    same_name_md = docx_path.with_suffix(".md")
    return same_name_md.exists()


def find_readme_issues() -> list[str]:
    issues: list[str] = []

    if not ROOT.exists():
        issues.append(f"Root folder missing: {ROOT.as_posix()}")
        return issues

    for dirpath, dirnames, filenames in os.walk(ROOT):
        current_dir = Path(dirpath)

        if is_ignored_path(current_dir):
            continue

        readme_candidates = [
            current_dir / "README.md",
            current_dir / "readme.md",
        ]

        existing_readmes = [p for p in readme_candidates if p.exists()]

        if not existing_readmes:
            issues.append(f"Missing README.md: {current_dir.as_posix()}")
            continue

        for readme in existing_readmes:
            if is_blank_readme(readme):
                issues.append(f"Blank README.md: {readme.as_posix()}")

    return issues


def detect_review_reasons(path: Path, document_type: str, suggested_path: str) -> list[str]:
    reasons: list[str] = []
    path_str = normalize_path(path)
    top = get_top_level_folder(path)

    if document_type == "Unknown / Needs Human Review":
        reasons.append("Unknown document type")

    if path.suffix.lower() not in ALLOWED_EXTENSIONS:
        reasons.append(f"Unusual file extension: {path.suffix}")

    if "prompt" in path.name.lower() and top == "02_Modules":
        reasons.append("Developer Prompt appears under 02_Modules; prompt originals should be under 05_Developer_Prompts")

    if document_type == "Main PRD" and top != "00_Main_PRD":
        reasons.append("Main PRD appears outside 00_Main_PRD")

    if document_type == "Architecture Governance" and top not in {"01_Architecture_Governance", "00_Index"}:
        reasons.append("Architecture Governance file may be outside governance/index folders")

    if document_type == "Release Note" and top != "06_Release_Notes":
        reasons.append("Release Note appears outside 06_Release_Notes")

    if document_type == "Support / Incident / Known Issue / Resolved Case" and top != "04_Support_Knowledge_Base":
        reasons.append("Support / Incident file appears outside 04_Support_Knowledge_Base")

    if path.suffix.lower() == ".zip" and top != "07_Archive":
        reasons.append("ZIP/package export should usually be under 07_Archive/Package_Export")

    if path.suffix.lower() == ".docx" and "Current" in path.parts:
        if not has_matching_md_for_docx(path):
            reasons.append("DOCX in Current is missing same-basename Markdown working file")

    if "Nexus_Lead_Ops" in path_str:
        reasons.append("Nexus_Lead_Ops path/name requires governance validation; likely maps to Lead_Console")

    if "{" in suggested_path or "Needs Human Review" in suggested_path:
        reasons.append("Suggested path requires human review")

    return reasons


def iter_files(root: Path) -> Iterable[Path]:
    for dirpath, dirnames, filenames in os.walk(root):
        current_dir = Path(dirpath)

        if is_ignored_path(current_dir):
            continue

        dirnames[:] = [d for d in dirnames if d not in IGNORE_DIR_NAMES]

        for filename in filenames:
            file_path = current_dir / filename
            if file_path.is_file():
                yield file_path


def build_inventory() -> list[AuditRow]:
    rows: list[AuditRow] = []

    if not ROOT.exists():
        return rows

    for file_path in sorted(iter_files(ROOT), key=lambda p: p.as_posix().lower()):
        document_type = infer_document_type(file_path)
        suggested = suggest_path(document_type, file_path)
        reasons = detect_review_reasons(file_path, document_type, suggested)

        rows.append(
            AuditRow(
                path=normalize_path(file_path),
                file_name=file_path.name,
                extension=file_path.suffix.lower(),
                size_bytes=file_path.stat().st_size,
                top_level_folder=get_top_level_folder(file_path),
                current_or_archive_status=get_current_or_archive_status(file_path),
                inferred_document_type=document_type,
                suggested_path=suggested,
                needs_human_review="yes" if reasons else "no",
                review_reasons="; ".join(reasons),
            )
        )

    return rows


def write_csv(rows: list[AuditRow]) -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    fieldnames = [
        "path",
        "file_name",
        "extension",
        "size_bytes",
        "top_level_folder",
        "current_or_archive_status",
        "inferred_document_type",
        "suggested_path",
        "needs_human_review",
        "review_reasons",
    ]

    with CSV_OUTPUT.open("w", newline="", encoding="utf-8-sig") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(asdict(row))


def summarize_by(rows: list[AuditRow], field_name: str) -> dict[str, int]:
    summary: dict[str, int] = {}
    for row in rows:
        value = getattr(row, field_name)
        summary[value] = summary.get(value, 0) + 1
    return dict(sorted(summary.items(), key=lambda item: item[0]))


def write_markdown_report(rows: list[AuditRow], readme_issues: list[str]) -> None:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    total_files = len(rows)
    review_count = sum(1 for row in rows if row.needs_human_review == "yes")

    by_type = summarize_by(rows, "inferred_document_type")
    by_top_folder = summarize_by(rows, "top_level_folder")
    by_current_status = summarize_by(rows, "current_or_archive_status")

    review_rows = [row for row in rows if row.needs_human_review == "yes"]

    lines: list[str] = []
    lines.append("# LOHAShare AI Platform New Document Intake Audit Report v0.1")
    lines.append("")
    lines.append("## 1. Workflow Scope")
    lines.append("")
    lines.append("This is a read-only audit report generated by `scripts/docops/intake_audit.py`.")
    lines.append("")
    lines.append("Safety boundary:")
    lines.append("")
    lines.append("- No files were modified.")
    lines.append("- No files were moved.")
    lines.append("- No files were deleted.")
    lines.append("- No Current files were overwritten.")
    lines.append("- No documents were promoted to Stable.")
    lines.append("- No GitHub commit was created by this script.")
    lines.append("")
    lines.append("## 2. Summary")
    lines.append("")
    lines.append(f"- Scanned root: `{ROOT.as_posix()}`")
    lines.append(f"- Total files scanned: **{total_files}**")
    lines.append(f"- Files needing human review: **{review_count}**")
    lines.append(f"- README issues found: **{len(readme_issues)}**")
    lines.append("")
    lines.append("## 3. Files by Inferred Document Type")
    lines.append("")
    lines.append("| Document Type | Count |")
    lines.append("|---|---:|")
    for key, value in by_type.items():
        lines.append(f"| {key or '(blank)'} | {value} |")
    lines.append("")
    lines.append("## 4. Files by Top-Level Folder")
    lines.append("")
    lines.append("| Top-Level Folder | Count |")
    lines.append("|---|---:|")
    for key, value in by_top_folder.items():
        lines.append(f"| {key or '(root)'} | {value} |")
    lines.append("")
    lines.append("## 5. Files by Current / Archive Status")
    lines.append("")
    lines.append("| Status | Count |")
    lines.append("|---|---:|")
    for key, value in by_current_status.items():
        lines.append(f"| {key or '(blank)'} | {value} |")
    lines.append("")
    lines.append("## 6. README Issues")
    lines.append("")
    if readme_issues:
        for issue in readme_issues:
            lines.append(f"- {issue}")
    else:
        lines.append("- No README issues found.")
    lines.append("")
    lines.append("## 7. Files Needing Human Review")
    lines.append("")
    if review_rows:
        lines.append("| Path | Inferred Type | Suggested Path | Review Reasons |")
        lines.append("|---|---|---|---|")
        for row in review_rows[:200]:
            lines.append(
                f"| `{row.path}` | {row.inferred_document_type} | `{row.suggested_path}` | {row.review_reasons} |"
            )
        if len(review_rows) > 200:
            lines.append("")
            lines.append(f"> Showing first 200 of {len(review_rows)} files needing human review.")
    else:
        lines.append("- No files need human review.")
    lines.append("")
    lines.append("## 8. Output Files")
    lines.append("")
    lines.append("- `docops_audit_output/new_document_intake_audit.csv`")
    lines.append("- `docops_audit_output/new_document_intake_audit_report.md`")
    lines.append("")
    lines.append("## 9. Next Recommended Step")
    lines.append("")
    lines.append("Review files marked `needs_human_review=yes` before creating any future migration, move, cleanup, or archive workflow.")
    lines.append("")

    MD_OUTPUT.write_text("\n".join(lines), encoding="utf-8")


def main() -> int:
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    if not ROOT.exists():
        write_csv([])
        MD_OUTPUT.write_text(
            "\n".join(
                [
                    "# LOHAShare AI Platform New Document Intake Audit Report v0.1",
                    "",
                    "## Error",
                    "",
                    f"Root folder not found: `{ROOT.as_posix()}`",
                    "",
                    "No files were modified.",
                ]
            ),
            encoding="utf-8",
        )
        return 1

    rows = build_inventory()
    readme_issues = find_readme_issues()

    write_csv(rows)
    write_markdown_report(rows, readme_issues)

    print("Audit complete.")
    print(f"CSV: {CSV_OUTPUT.as_posix()}")
    print(f"Report: {MD_OUTPUT.as_posix()}")
    print(f"Total files scanned: {len(rows)}")
    print(f"Files needing human review: {sum(1 for row in rows if row.needs_human_review == 'yes')}")
    print(f"README issues: {len(readme_issues)}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
