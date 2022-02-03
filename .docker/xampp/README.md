# XAMPP



# .ENV FILE
You can edit the .env file to change the version of php you want to run. Default is set to php8

# Starting the project

If you use DockeRino. You now should have a folder named %PROJECT_NAME% on your Desktop with this README.md a docker-compose file and a project folder

To run the project :
```
cd %PROJECT_NAME%
```
```
docker-compose up
```

The project folder serve an index.php with a Database class, it should output "Successfuly connected to the database !" when you run the project and go to http://localhost:80/www 

# PORTS

- You can go to http://localhost:80 to see the dashboard homepage of XAMPP
- You can go to http://localhost:80/phpmyadmin to access the pma gui directly
- You can go to http://localhost:80/www to see your website
    By default it should ouptut "Successfuly connected to the database !"
- You can use the ssh connection via port 22 (default SSH password is 'root')
```
ssh root@localhost -p 22
```