from flask import Flask
import time

app = Flask(__name__)

@app.route('/')
def hello_geek():
    return '<h1>Hello from Flask & Docker</h2>'

@app.route('/largest-prime-factor/<num>')
def get_largest_prime_factor(num):
    start_time = time.time()
    ans = str(largest_prime_factor(int(num)))
    end_time = time.time()
    taken_time = end_time - start_time
    print("request='" + num + "' response='" + ans + "' request_digets='" + str(len(num)) + "' time_taken='" + str(taken_time) + "'")
    return ans

def largest_prime_factor(n):
    i = 2
    while i * i <= n:
        if n % i:
            i += 1
        else:
            n //= i
    return n

if __name__ == "__main__":
    app.run(debug=True) 