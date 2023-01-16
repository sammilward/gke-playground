from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_geek():
    return '<h1>Hello from Flask & Docker</h2>'

@app.route('/largest-prime-factor/<num>')
def get_largest_prime_factor(num):
    return str(largest_prime_factor(int(num)))

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