<?php

class Database
{
    private static $conn;
    private static $host = "localhost";
    private static $port = 3306;
    private static $user = "root";
    private static $pwd = "";
    private static $db_name = "test";

    public static function init()
    {
        try {
            self::$conn = new PDO("mysql:host=" . self::$host . ";port=" . self::$port . ";dbname=" . self::$db_name, self::$user, self::$pwd, array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));
        } catch (PDOException $except) {
            throw $except;
        }

        return "Successfuly connected to the database !";
    }
}