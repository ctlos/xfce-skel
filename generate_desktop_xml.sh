#!/bin/bash

output_file="etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml"
wallpaper_path="/usr/share/wall/ctld.png"

cat <<EOF > "$output_file"
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
EOF

# Список мониторов
monitors=(
  "monitor0" "monitor1" "monitorVGA-1" "monitorHDMI1"
  "monitorHDMI2" "monitorLVDS1" "monitorDVI-I-1"
  "monitorDVI-D-1" "monitorDVI-D-0" "monitorHDMI-0"
  "monitorHDMI-1" "monitorHDMI-2" "monitorVirtual1"
  "monitorVirtual2" "monitorVirtual-1" "monitorVirtual-2"
  "monitorDP-0" "monitorDP-1" "monitorLVDS-1"
)

for monitor in "${monitors[@]}"; do
  cat <<EOF >> "$output_file"
      <property name="$monitor" type="empty">
EOF

  # 4 рабочих пространства
  for workspace in {0..3}; do
    cat <<EOF >> "$output_file"
        <property name="workspace$workspace" type="empty">
          <property name="color-style" type="int" value="0"/>
          <property name="image-style" type="int" value="5"/>
          <property name="last-image" type="string" value="$wallpaper_path"/>
        </property>
EOF
  done

  cat <<EOF >> "$output_file"
      </property>
EOF
done

cat <<EOF >> "$output_file"
    </property>
  </property>
  <property name="desktop-icons" type="empty">
    <property name="file-icons" type="empty">
      <property name="show-filesystem" type="bool" value="false"/>
      <property name="show-removable" type="bool" value="false"/>
    </property>
    <property name="tooltip-size" type="double" value="48.000000"/>
    <property name="icon-size" type="uint" value="36"/>
    <property name="use-custom-font-size" type="bool" value="true"/>
    <property name="font-size" type="double" value="10.000000"/>
  </property>
</channel>
EOF

echo "Файл $output_file успешно создан"