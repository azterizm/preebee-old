WORKING_DIR='/home/abdiel/Code/preebee-old/seller-dashboard'
REMOTE_SERVER='root@176.57.189.216'
PACKAGE_NAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

cd $WORKING_DIR

# Build
npm run build

# Package
zip -r $PACKAGE_NAME.zip build .env.prod package.json package-lock.json public

# Transfer
sftp $REMOTE_SERVER <<EOF
cd eros
put $PACKAGE_NAME.zip
exit
EOF

# Deploy
ssh $REMOTE_SERVER <<EOF
cd eros
mv seller-dashboard/uploads .
rm -rf seller-dashboard
mkdir seller-dashboard
mv uploads seller-dashboard
mv $PACKAGE_NAME.zip seller-dashboard
cd seller-dashboard
unzip $PACKAGE_NAME.zip
rm $PACKAGE_NAME.zip
mv .env.prod .env
npm install --omit=dev
cd .. 
npx prisma generate
pm2 restart eros-seller
exit
EOF

# Cleanup
cd $WORKING_DIR
rm -rf $PACKAGE_NAME.zip 

echo "Deployed Seller Dashboard to $REMOTE_SERVER"
