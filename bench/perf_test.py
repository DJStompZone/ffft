import subprocess
import time
import statistics

def run_test(executable, iterations=1000):
    durations = []

    for _ in range(iterations):
        start = time.perf_counter()
        subprocess.run([executable], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        end = time.perf_counter()
        durations.append(end - start)

    print(f"Ran {iterations} iterations of {executable}")
    print(f"Min time:  {min(durations) * 1e6:.2f} µs")
    print(f"Max time:  {max(durations) * 1e6:.2f} µs")
    print(f"Mean time: {statistics.mean(durations) * 1e6:.2f} µs")
    print(f"Std dev:   {statistics.stdev(durations) * 1e6:.2f} µs")

if __name__ == '__main__':
    run_test('./fft_test', iterations=1000)
