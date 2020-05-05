<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1588657788871" ID="ID_1991258599" MODIFIED="1588657840805" STYLE="bubble" TEXT="Landing Zone Security Model">
<node COLOR="#111111" CREATED="1588656286579" ID="ID_1408528114" MODIFIED="1588667500369" POSITION="right" TEXT="Layers (Itteration 1)">
<arrowlink COLOR="#3333ff" DESTINATION="ID_242178712" ENDARROW="Default" ENDINCLINATION="333;0;" ID="Arrow_ID_908963582" STARTARROW="None" STARTINCLINATION="333;0;"/>
<node COLOR="#111111" CREATED="1588656294938" ID="ID_600957945" MODIFIED="1588657840805" TEXT="Base Infrastructure (Node-level)">
<node COLOR="#111111" CREATED="1588656370359" ID="ID_659680870" MODIFIED="1588657840805" TEXT="IAM Parameterised within Terraform"/>
<node COLOR="#111111" CREATED="1588656556954" ID="ID_1909090528" MODIFIED="1588657840805" TEXT="IAM drives ClusterRoles / ClusterRoleBindings">
<node COLOR="#111111" CREATED="1588655428715" ID="ID_1154117484" LINK="https://kubernetes.io/docs/reference/access-authn-authz/rbac/" MODIFIED="1588657840805" TEXT="Kubernetes RBAC Docs"/>
</node>
</node>
<node COLOR="#111111" CREATED="1588656315333" ID="ID_14598209" MODIFIED="1588657840806" TEXT="Pod Service Accounts level">
<node COLOR="#111111" CREATED="1588656400431" ID="ID_1823904601" MODIFIED="1588657840806" TEXT="Roles / RoleBindings within Kubernetes/OpenShift">
<node COLOR="#111111" CREATED="1588656643815" ID="ID_1472654783" MODIFIED="1588657840806" TEXT="Where are these stored, and how accessed?">
<node COLOR="#111111" CREATED="1588656659891" ID="ID_309058448" MODIFIED="1588657840806" TEXT="Derived from Terraform?"/>
<node COLOR="#111111" CREATED="1588656670317" ID="ID_1453225830" MODIFIED="1588657840806" TEXT="Held within Vault?"/>
<node COLOR="#111111" CREATED="1588656801598" ID="ID_630538251" MODIFIED="1588657840806" TEXT="Kubernetes holds a manifest file containing RBAC objects"/>
</node>
<node COLOR="#111111" CREATED="1588656750551" ID="ID_869209925" MODIFIED="1588657840806" TEXT="Roles are immutable once bound, only RoleBindings can change dynamically"/>
<node COLOR="#111111" CREATED="1588656919468" ID="ID_504766550" MODIFIED="1588657840806" TEXT="A Pod would have to kubectl/API to request a change in its authorisations???"/>
<node COLOR="#111111" CREATED="1588655428715" ID="ID_766975755" LINK="https://kubernetes.io/docs/reference/access-authn-authz/rbac/" MODIFIED="1588657840806" TEXT="Kubernetes RBAC Docs"/>
</node>
<node COLOR="#111111" CREATED="1588657323722" ID="ID_1726339531" MODIFIED="1588657840806" TEXT="Default RBAC policies grant scoped permissions to control-plane components, nodes, and controllers, but grant no permissions to service accounts outside the kube-system namespace (beyond discovery permissions given to all authenticated users)."/>
<node COLOR="#111111" CREATED="1588657323726" ID="ID_925570974" MODIFIED="1588657840808" TEXT="This allows you to grant particular roles to particular ServiceAccounts as needed. Fine-grained role bindings provide greater security, but require more effort to administrate. Broader grants can give unnecessary (and potentially escalating) API access to ServiceAccounts, but are easier to administrate."/>
<node COLOR="#111111" CREATED="1588657582238" ID="ID_852685324" MODIFIED="1588657840809" TEXT="The RBAC API prevents users from escalating privileges by editing roles or role bindings. Because this is enforced at the API level, it applies even when the RBAC authorizer is not in use."/>
<node COLOR="#111111" CREATED="1588657634624" ID="ID_579406748" MODIFIED="1588657840810" TEXT="Roles for Built-in Controllers">
<node COLOR="#111111" CREATED="1588657668928" ID="ID_488028097" MODIFIED="1588657840811" TEXT="The Kubernetes controller manager runs controllers that are built in to the Kubernetes control plane. When invoked with --use-service-account-credentials, kube-controller-manager starts each controller using a separate service account. Corresponding roles exist for each built-in controller, prefixed with system:controller:. If the controller manager is not started with --use-service-account-credentials, it runs all control loops using its own credential, which must be granted all the relevant roles. These roles include:">
<node COLOR="#111111" CREATED="1588657715011" ID="ID_705991810" MODIFIED="1588657840813" TEXT="--use-service-account-credentials">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node COLOR="#111111" CREATED="1588657348071" ID="ID_829257037" MODIFIED="1588657840813" TEXT="Approaches (see Kubernetes RBAC docs)">
<node COLOR="#111111" CREATED="1588657391735" ID="ID_355502890" MODIFIED="1588657840813" TEXT="(Most Secure): 1.Grant a role to an application-specific service account (best practice)">
<font BOLD="true" NAME="SansSerif" SIZE="12"/>
</node>
<node COLOR="#111111" CREATED="1588657421586" ID="ID_811629648" MODIFIED="1588657840813" TEXT="(Less Secure):  2.Grant a role to the &#x201c;default&#x201d; service account in a namespace"/>
<node COLOR="#111111" CREATED="1588657464160" ID="ID_510143658" MODIFIED="1588657840813" TEXT="(Even Less Secure): 3.Grant a role to all service accounts in a namespace"/>
<node COLOR="#111111" CREATED="1588657499309" ID="ID_601559489" MODIFIED="1588657840813" TEXT="(Insecure): 4.Grant a limited role to all service accounts cluster-wide (discouraged)"/>
<node COLOR="#111111" CREATED="1588657524829" ID="ID_662525058" MODIFIED="1588657840813" TEXT="(Least Secure): 5.Grant super-user access to all service accounts cluster-wide (strongly discouraged)"/>
</node>
</node>
<node COLOR="#111111" CREATED="1588657082373" ID="ID_1117366230" MODIFIED="1588657840813" TEXT="Pod-level Authenticated End-Users?"/>
<node COLOR="#111111" CREATED="1588656327737" ID="ID_308424927" MODIFIED="1588658771959" TEXT="Authenticated End-User Access (Vault)">
<linktarget COLOR="#ff0000" DESTINATION="ID_308424927" ENDARROW="Default" ENDINCLINATION="907;0;" ID="Arrow_ID_1225839506" SOURCE="ID_800502734" STARTARROW="None" STARTINCLINATION="907;0;"/>
<node COLOR="#111111" CREATED="1588656459387" ID="ID_478286245" MODIFIED="1588657840814" TEXT="Authentication Service">
<node CREATED="1588667393752" ID="ID_161432183" MODIFIED="1588667402537" TEXT="Maybe Kubernetes Auth?"/>
</node>
<node COLOR="#111111" CREATED="1588656472894" ID="ID_578557987" MODIFIED="1588657840814" TEXT="Tokens provide access to Secrets Store">
<node COLOR="#111111" CREATED="1588656501129" ID="ID_1338023700" MODIFIED="1588657840814" TEXT="API Access Keys"/>
</node>
<node COLOR="#111111" CREATED="1588656993485" ID="ID_1931780807" MODIFIED="1588657840814" TEXT="Segregate Pod Service Accounts from End-user Accounts?"/>
</node>
</node>
<node CREATED="1588667467417" ID="ID_242178712" MODIFIED="1588667508362" POSITION="right" TEXT="Itterative Landing Zone re-factoring">
<arrowlink COLOR="#3333ff" DESTINATION="ID_1289435854" ENDARROW="Default" ENDINCLINATION="110;0;" ID="Arrow_ID_1596947990" STARTARROW="None" STARTINCLINATION="110;0;"/>
<linktarget COLOR="#3333ff" DESTINATION="ID_242178712" ENDARROW="Default" ENDINCLINATION="333;0;" ID="Arrow_ID_908963582" SOURCE="ID_1408528114" STARTARROW="None" STARTINCLINATION="333;0;"/>
</node>
<node CREATED="1588667320645" ID="ID_1289435854" MODIFIED="1588667502320" POSITION="right" TEXT="Layers (itteration n)">
<linktarget COLOR="#3333ff" DESTINATION="ID_1289435854" ENDARROW="Default" ENDINCLINATION="110;0;" ID="Arrow_ID_1596947990" SOURCE="ID_242178712" STARTARROW="None" STARTINCLINATION="110;0;"/>
<node COLOR="#111111" CREATED="1588656294938" ID="ID_1600143094" MODIFIED="1588657840805" TEXT="Base Infrastructure (Node-level)">
<node COLOR="#111111" CREATED="1588656370359" ID="ID_594257584" MODIFIED="1588657840805" TEXT="IAM Parameterised within Terraform"/>
<node COLOR="#111111" CREATED="1588656556954" ID="ID_1485032854" MODIFIED="1588657840805" TEXT="IAM drives ClusterRoles / ClusterRoleBindings">
<node COLOR="#111111" CREATED="1588655428715" ID="ID_353242835" LINK="https://kubernetes.io/docs/reference/access-authn-authz/rbac/" MODIFIED="1588657840805" TEXT="Kubernetes RBAC Docs"/>
</node>
</node>
<node COLOR="#111111" CREATED="1588656315333" ID="ID_561881796" MODIFIED="1588657840806" TEXT="Pod Service Accounts level">
<node CREATED="1588667425460" ID="ID_538537051" MODIFIED="1588667432127" TEXT="Migrated to Vault"/>
</node>
<node COLOR="#111111" CREATED="1588657082373" ID="ID_1042819997" MODIFIED="1588657840813" TEXT="Pod-level Authenticated End-Users?">
<node CREATED="1588667436626" ID="ID_1973057067" MODIFIED="1588667442432" TEXT="Migrated to Vault"/>
</node>
<node COLOR="#111111" CREATED="1588656327737" ID="ID_1787726694" MODIFIED="1588667418690" TEXT="Authenticated End-User Access (Vault)">
<node CREATED="1588667447653" ID="ID_191894308" MODIFIED="1588667452804" TEXT="Vault from Day 1"/>
</node>
</node>
<node CREATED="1588657926602" ID="ID_280015837" MODIFIED="1588658754053" POSITION="left" TEXT="Role of Vault">
<node COLOR="#111111" CREATED="1588656327737" ID="ID_800502734" MODIFIED="1588667418690" TEXT="Authenticated End-User Access (Vault)">
<arrowlink COLOR="#ff0000" DESTINATION="ID_308424927" ENDARROW="Default" ENDINCLINATION="907;0;" ID="Arrow_ID_1225839506" STARTARROW="None" STARTINCLINATION="907;0;"/>
</node>
</node>
</node>
</map>
