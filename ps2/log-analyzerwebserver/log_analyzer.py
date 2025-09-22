#!/usr/bin/env python3
import re
from collections import Counter
import sys

log_pattern = re.compile(
    r'(?P<ip>\d+\.\d+\.\d+\.\d+) - - \[(?P<time>[^\]]+)\] '
    r'"(?P<method>[A-Z]+) (?P<page>[^ ]+) [^"]+" '
    r'(?P<status>\d{3}) (?P<size>\d+)'
)

def analyze_log(file_path):
    total_requests = 0
    status_counter = Counter()
    page_counter = Counter()
    ip_counter = Counter()
    errors_404 = 0

    report_lines = []  # To store report for file output

    try:
        with open(file_path, "r") as f:
            for line in f:
                match = log_pattern.match(line)
                if match:
                    total_requests += 1
                    status = match.group("status")
                    page = match.group("page")
                    ip = match.group("ip")

                    status_counter[status] += 1
                    page_counter[page] += 1
                    ip_counter[ip] += 1

                    if status == "404":
                        errors_404 += 1

        # Prepare report
        report_lines.append("\n===== Web Server Log Analysis Report =====")
        report_lines.append(f"Total Requests: {total_requests}")
        report_lines.append(f"Total 404 Errors: {errors_404}")

        report_lines.append("\n--- Status Code Summary ---")
        for code, count in status_counter.items():
            report_lines.append(f"{code}: {count}")

        report_lines.append("\n--- Top 10 Requested Pages ---")
        for page, count in page_counter.most_common(10):
            report_lines.append(f"{page}: {count}")

        report_lines.append("\n--- Top 10 IP Addresses ---")
        for ip, count in ip_counter.most_common(10):
            report_lines.append(f"{ip}: {count}")

        report_lines.append("==========================================\n")

        # Print to console
        for line in report_lines:
            print(line)

        # Save to report file
        with open("report.txt", "w") as report_file:  # 'w' to overwrite each run
            for line in report_lines:
                report_file.write(line + "\n")

        print("\n✅ Report saved to ~/log-analyzer/report.txt")

    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python log_analyzer.py <log_file>")
    else:
        analyze_log(sys.argv[1])

