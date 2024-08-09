WORKING_DIR='/home/abdiel/Code/preebee-old/owner-dashboard/'
REMOTE_SERVER='root@176.57.189.216'
PACKAGE_NAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

cd $WORKING_DIR

# Build
npm run build

# Package
zip -r $PACKAGE_NAME.zip build .env.prod package.json remix.config.js public package-lock.json

# Transfer
sftp $REMOTE_SERVER <<EOF
cd eros 
put $PACKAGE_NAME.zip
exit
EOF

# Deploy
ssh $REMOTE_SERVER <<EOF
cd eros
mv owner-dashboard/uploads .
rm -rf owner-dashboard
mkdir owner-dashboard
mv uploads owner-dashboard
mv $PACKAGE_NAME.zip owner-dashboard
cd owner-dashboard
unzip $PACKAGE_NAME.zip
rm $PACKAGE_NAME.zip
mv .env.prod .env
npm install --omit=dev
cd ..
npx prisma generate
pm2 restart eros-owner
exit
EOF

# Cleanup
cd $WORKING_DIR
rm -rf $PACKAGE_NAME.zip 

echo "Deployed Owner to $REMOTE_SERVER"
