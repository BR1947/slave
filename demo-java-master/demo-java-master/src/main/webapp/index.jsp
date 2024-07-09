<!DOCTYPE html>
<html>
<head>
    <title>Simple JSP Example</title>
</head>
<body>
    <h1>Simple JSP Form</h1>
    <form action="submit.jsp" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
        <br><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <br><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>

