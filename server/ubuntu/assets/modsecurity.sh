######## modsecurity #########

apt install libapache2-mod-security2 -y
a2enmod security2
cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf 
sed -i 's|SecRuleEngine DetectionOnly|SecRuleEngine On|g' /etc/modsecurity/modsecurity.conf 
sed -i 's|SecAuditLogParts ABDEFHIJZ|SecAuditLogParts ABCEFHJKZ|g' /etc/modsecurity/modsecurity.conf 
mkdir /etc/apache2/modsecurity/
wget https://github.com/coreruleset/coreruleset/archive/refs/tags/v4.20.0.tar.gz
tar xvf v4.20.0.tar.gz -C /etc/apache2/modsecurity
cp /etc/apache2/modsecurity/coreruleset-4.20.0/crs-setup.conf.example /etc/apache2/modsecurity/coreruleset-4.20.0/crs-setup.conf
cp /etc/apache2/mods-enabled/security2.conf /etc/apache2/mods-enabled/security2.conf.original
> /etc/apache2/mods-enabled/security2.conf

cat <<EOT >> /etc/apache2/mods-enabled/security2.conf

<IfModule security2_module>
    # Default Debian dir for modsecurity's persistent data
    SecDataDir /var/cache/modsecurity

    # Include all the *.conf files in /etc/modsecurity.
    IncludeOptional /etc/modsecurity/*.conf

    # Include OWASP ModSecurity CRS rules if installed
    Include /etc/apache2/modsecurity/coreruleset-4.20.0/crs-setup.conf
    Include /etc/apache2/modsecurity/coreruleset-4.20.0/rules/*.conf
</IfModule>

EOT

systemctl restart apache2

echo "######## SET MODSECURITY - DONE! ########"
##############################