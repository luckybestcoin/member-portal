<!DOCTYPE html>
<html>
<body>
    Hy {{ $data['name'] }}, this is your password recovery link:<br><br>
    <a href="https://member.luckybestcommunity.com/recovery?token={{ $data['token'] }}" target="_blank">https://member.luckybestcommunity.com/recovery?token={{ $data['token'] }}</a><br>
    Thank You
    <br><br>
    <div style="text-align: center">
        This email was sent to {{ $data['email'] }}<br>
        You received this email because you are registered with <a href="https://luckybestcommunity.com">Lucky Best Coin</a>
    </div>
</body>
</html>

