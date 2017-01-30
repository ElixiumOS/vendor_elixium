# Copyright (C) 2017 ElixiumOS
# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
LOCAL_PATH := $(call my-dir)

#The base work is from cyanogenmod, i have only extracted what i need

include $(CLEAR_VARS)
internal_src := src/org/cyanogenmod/internal

LOCAL_MODULE := minimal-sdk
LOCAL_MODULE_TAGS := optional

LOCAL_JAVA_LIBRARIES := \
    android-support-v7-preference \
    android-support-v7-recyclerview \
    services \
    android-support-v14-preference

LOCAL_SRC_FILES := \
    $(call all-java-files-under, $(internal_src))

include $(BUILD_JAVA_LIBRARY)


