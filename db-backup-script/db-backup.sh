
#!/bin/sh -x
echo "Openmrs Backup Started"

echo y | bahmni -i local backup --backup_type=db --options=openmrs

echo "Openmrs Backup Successfully Done"
backup_date=$(date +"%d-%m-%Y")
backup_time=$(date +%T)
backup_path="$backup_date/$backup_time/"

echo "backup moving started at" $backup_date $backup_time
cd /opt/openmrs-database-backup/

mkdir -p $backup_path && cd $backup_path
echo "Backup path"
pwd
sudo cp -rf /data/openmrs .

sudo find /opt/openmrs-database-backup/* -mtime +15 -exec rm -rf {} \;

echo "Done ... !!! backup moved"





