<!DOCTYPE html>
<html>
<body>
    Hy {{ $data['name'] }}, welcome to Lucky Best Coin System. Click to this link below to activate your account;<br><br>
    <a href="http://member.luckybestcoin.com/referral?token={{ $data['token'] }}" target="_blank">https://member.luckybestcoin.com/referral?token={{ $data['token'] }}</a><br>
    Or use this referral code : {{ $data['token'] }}<br><br>
    Thank You
    <br><br>
    <div style="text-align: center">
        This email was sent to {{ $data['email'] }}<br>
        You received this email because you are registered with <a href="https://luckybestcoin.com">Lucky Best Coin</a>
    </div>
</body>
</html>

