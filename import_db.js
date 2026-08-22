const mysql = require('mysql2/promise');
const fs = require('fs');

async function importDb() {
  console.log("Connecting to the database...");
  const connection = await mysql.createConnection({
    host: 'altaria.proxy.rlwy.net',
    port: 53223,
    user: 'root',
    password: 'creAXDuMuqcMMrpxyIBJtpRNGvfGsuuH',
    database: 'railway',
    multipleStatements: true
  });
  
  console.log("Reading SQL file...");
  const sql = fs.readFileSync('local_backup.sql', 'utf8');
  console.log("File read. Executing...", sql.length, "bytes");
  
  await connection.query(sql);
  console.log("Import completed successfully!");
  
  await connection.end();
}

importDb().catch(err => {
    console.error("An error occurred during import:");
    console.error(err);
    process.exit(1);
});
