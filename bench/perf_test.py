import os
import subprocess
import time
import statistics
import argparse

try:
    from tqdm import tqdm
except ImportError:
    tqdm = lambda x, **kwargs: x  # Fallback if tqdm isn't installed

def run_test(executable='ffft', iterations=1000, show_progress=True):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    executable_path = executable if os.path.isabs(executable) else os.path.join('..', executable)

    if not os.path.exists(executable_path):
        raise FileNotFoundError(f"Executable not found: {executable_path}")

    durations = []
    loop = tqdm(range(iterations), disable=not show_progress, desc="Benchmarking")
    for _ in loop:
        start = time.perf_counter()
        subprocess.run(['bash', executable_path], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        end = time.perf_counter()
        durations.append(end - start)

    print(f"Ran {iterations} iterations of {executable}")
    print(f"Min time:  {min(durations) * 1e6:.2f} µs")
    print(f"Max time:  {max(durations) * 1e6:.2f} µs")
    print(f"Mean time: {statistics.mean(durations) * 1e6:.2f} µs")
    print(f"Std dev:   {statistics.stdev(durations) * 1e6:.2f} µs")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Benchmark FFFT executable.")
    parser.add_argument("-e", "--executable", default="ffft", help="Path to the compiled FFFT binary.")
    parser.add_argument("-n", "--iterations", type=int, default=1000, help="Number of benchmark runs.")
    parser.add_argument("--noprogress", action="store_true", help="Disable progress bar")

    args = parser.parse_args()
    run_test(executable=args.executable, iterations=args.iterations or 1000, show_progress=not args.noprogress)
