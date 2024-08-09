WORKING_DIR='/home/abdiel/Code/preebee-old/'
REMOTE_SERVER='root@176.57.189.216'
PACKAGE_NAME='prisma'

cd $WORKING_DIR

# Package
zip -r $PACKAGE_NAME.zip prisma .env.prod package.json package-lock.json

# Transfer
sftp $REMOTE_SERVER <<EOF
cd eros
put $PACKAGE_NAME.zip
exit
EOF

# Deploy
ssh $REMOTE_SERVER <<EOF
cd eros
rm -rf prisma .env.prod .env package.json package-lock.json node_modules
unzip $PACKAGE_NAME.zip
mv .env.prod .env
npm install
npx prisma migrate deploy
npx prisma generate
pm2 restart eros-seller eros-marketplace 
EOF

# Cleanup
cd $WORKING_DIR
rm -rf $PACKAGE_NAME.zip 

echo "Deployed DB to $REMOTE_SERVER"
