import os
import time
import random
import requests

url = os.getenv('SERVER_ADDR')
if url is None:
   print("SERVER_ADDR env variable is not defined")
   exit(1)

rps_str = os.getenv('REQUESTS_PER_SECOND')
if rps_str is None:
   print("REQUESTS_PER_SECOND env variable is not defined")
   exit(1)
rps = int(rps_str)

print("Starting loadgen: %s" % time.time())

while 1:
   time.sleep(1)
   i = 0
   while i < rps:
      i+=1
      rand = random.randint(3794392793739, 8329432794394345)
      rand_url = url+"/largest-prime-factor/"+str(rand)
      resp = requests.get(rand_url)
      print("request='" + str(rand) + "' response='" + str(resp.text) + "'")