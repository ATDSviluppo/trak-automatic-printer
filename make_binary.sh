#!/bin/bash

podman create --name trak_aprinter_temp trak_aprinter_builder
podman cp trak_aprinter_temp:/output/trak_aprinter ./output/trak_aprinter
podman rm trak_aprinter_temp
chmod +x ./output/trak_aprinter
