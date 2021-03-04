<!DOCTYPE html>
<html>
<body>
    Hy {{ $name }}, this is your password recovery link:<br><br>
    <a href="https://member.luckybestcoin.com/recovery?token={{ $token }}" target="_blank">https://member.luckybestcoin.com/recovery?token={{ $token }}</a><br>
    Thank You
    <br><br>
    <div style="text-align: center">
        This email was sent to {{ $email }}<br>
        You received this email because you are registered with <a href="https://luckybestcoin.com">Lucky Best Coin</a>
    </div>
</body>
</html>
