import string
import random

aws_user_accounts = [
    ''.join([random.choice(string.digits) for _ in range(13)])
    for _ in range(1000)
]

print("\n    - ".join(aws_user_accounts))