#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

XCASSET_FILES=()

realpath() {
  DIRECTORY=$(cd "${1%/*}" && pwd)
  FILENAME="${1##*/}"
  echo "$DIRECTORY/$FILENAME"
}

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ABSOLUTE_XCASSET_FILE=$(realpath "${PODS_ROOT}/$1")
      XCASSET_FILES+=("$ABSOLUTE_XCASSET_FILE")
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_resource "SlimeRefresh/SlimeRefresh/SlimeRefresh/sr_refresh.png"
  install_resource "SlimeRefresh/SlimeRefresh/SlimeRefresh/sr_refresh@2X.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/zh-Hans.lproj/UMFeedbackLocalizable.strings"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/bubble_min@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/microphone@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/save@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputText@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputTextHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputVoice@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputVoiceHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_add_photo@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_dialog_cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_dialog_content@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_01@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_02@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_03@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_default@2x.png"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/UMSocialSDKResourcesNew.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/TencentOpenApi_IOS_Bundle.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentDetailController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSLoginViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSnsAccountViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSShareListController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/en.lproj"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/zh-Hans.lproj"
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_resource "SlimeRefresh/SlimeRefresh/SlimeRefresh/sr_refresh.png"
  install_resource "SlimeRefresh/SlimeRefresh/SlimeRefresh/sr_refresh@2X.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/zh-Hans.lproj/UMFeedbackLocalizable.strings"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/bubble_min@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/microphone@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/save@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputText@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputTextHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputVoice@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/ToolViewInputVoiceHL@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_add_photo@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_dialog_cancel@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_dialog_content@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_01@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_02@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_03@2x.png"
  install_resource "UMengFeedback/UMFeedback_iOS_2.3.1/UMengFeedback_SDK_2.3.1/Resources/umeng_fb_audio_play_default@2x.png"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/UMSocialSDKResourcesNew.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_Extra_Frameworks/TencentOpenAPI/TencentOpenApi_IOS_Bundle.bundle"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentDetailController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSCommentInputControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMShareEditViewControlleriPad.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSLoginViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSnsAccountViewController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/SocialSDKXib/UMSShareListController.xib"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/en.lproj"
  install_resource "UMengSocial/umeng_ios_social_sdk_4.2.3_arm64_custom/UMSocial_Sdk_4.2.3/zh-Hans.lproj"
fi

rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ -n "$XCASSET_FILES" ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac

  # Find all other xcassets (this unfortunately includes those of path pods and other targets).
  OTHER_XCASSETS=$(find "$PWD" -iname "*.xcassets" -type d)
  while read line; do
    if [[ $line != "`realpath $PODS_ROOT`*" ]]; then
      XCASSET_FILES+=("$line")
    fi
  done <<<"$OTHER_XCASSETS"

  printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
