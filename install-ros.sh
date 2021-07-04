#!/bin/bash -e

# Reference sites
# https://www.stereolabs.com/blog/ros-and-nvidia-jetson-nano/

echo "[Add the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros-latest.list ]; then
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
fi

curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "[Update the package]"
sudo apt-get update

echo "[Installing ROS and ROS Packages]"
sudo apt-get install -y ros-melodic-desktop

# need for check
sudo apt install python-rosdep

echo "[rosdep init and python-rosinstall]"
sudo rosdep init
rosdep update
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo "[Making the catkin workspace and testing the catkin build]"
sudo apt-get install -y cmake python-rosinstall python-catkin-tools
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws
source /opt/ros/melodic/setup.bash
catkin init
catkin build
sh -c "echo \"source ~/catkin_ws/devel/setup.bash\" >> ~/.bashrc"
source ~/.bashrc
