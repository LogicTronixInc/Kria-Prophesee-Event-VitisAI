#Nikil Thapa (Aug 9)
#Generate Pre-processor xo file and SD card files
export CUR_DIR=$PWD
export TRD_PATH=$CUR_DIR/DPU-TRD/DPUCZDX8G/

#Generate vadd xo file
#cd $CUR_DIR/../../../../plugins/vadd/pl
#make cleanall
#make xo TARGET=hw BOARD=Zynq ARCH=aarch64


#Generate histoframe xo file
cd $CUR_DIR/../../../../plugins/histoframe/pl

make cleanall
#make xo TARGET=hw BOARD=Zynq ARCH=aarch64 BLOB_CHANNEL_SWAP_EN=0 BLOB_CROP_EN=0 BLOB_LETTERBOX_EN=0 BLOB_JPEG_EN=0 BLOB_NPC=1
make xo TARGET=hw BOARD=Zynq ARCH=aarch64





#Generate SD card files
cd $CUR_DIR
make all KERNEL=DPU_PP ACCEL_1=../../../../plugins/histoframe/pl ACCEL_2=../../../../plugins/vadd/pl DEVICE=KV260
