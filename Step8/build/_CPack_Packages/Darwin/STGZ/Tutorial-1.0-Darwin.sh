#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0-Darwin subdirectory
  --exclude-subdir  exclude the Tutorial-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tutorial/Step8...

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0-Darwin\""
    echo "Do you want to include the subdirectory Tutorial-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +152 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Tutorial-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� 3�gb �}x[ŕ�H��v"���Sr�&� J$�'!�4�Tib0�M>�kٖm����b*Hҵ"�j��/�g���^>J�yw���:�%.��ǣ�+�kڄ^���-�~gfΕteIvbhwΗ{Ϝ9gΜ�9w���դ�۹��c���UÕ�K�9F��e�����2��pT:��Tq��
�~0��PN9km���v$�_4��ׇ�]~��w���9��J�����W�����W�~�J��������y!��p������=�O2�%p��R�����o���<U�a�P==F��^�V���3� ��x��lE	zz�I�t}Wr}?�0I���#�TRQ�PS ������J�50���>������3賮��O��Ɯ��57+��fOwP	�������`
�ӗ�����mY����\__
�
�A_Wg �B��-���RhSN�B�wy;[ogkW}ըo$���^�w������+n���ks��]6�Ee��|[W��eշ�$���� mI�KM�Ia���
g�Kk����J`gGS�O����I�S�����v�����v&�Q�מB랯4H�[6ݴY޸I��vs�86�s�,����p#�p�!̐�%$f�����w�:n��l��,�t-�܊W!\��|6�B���	��b�V��U>oӪ����_�z����{�����ί~z�t�\��x�*SK�����x5�~��U���Y*�z�X󉂈�jM�W�5׬t���ML�:E>��8?]�ng ��X�i,��J�����H�� @�  @�  @�  @� 8hpEN�v��xL�����	W$��;a�����ኮ[q	Er����� 9��W����N�/-��j�}�wH������h��"�Ww�ڟPr_E��4WP�aR5P��J=�ж�j{��xuT�0��;�<���6��ɣ�TD>��-p?����R���-%r�8m�k_���h�U��*M�귋�m���� T�h�z�\V���]���2�iz)�����w1�sav�:��t`�H��(��K :>2���]Gw�����m)�,ޝ:>�GD&\Q����^�564�^��:sE^P]��uT��b�JM�e�S�gM�7�Q�-�����d�̮�&�e��8o�����BVe�2W��|��Љ�aD%��n�eq8�=�����,d[�s����g}�E"��Љ'Tԥ�	��0�}�,c���!�e��q��\�T��1"��4ڑ��ˀ�2Q����&$˞��L���f-���m�W��RW�N�N�"?��+R����&�rϗ'''��������h�A�h�����j{dOwR��A�04gX�#hK4�^nSJ���	w��&����G#?�&Ӭ�\�U�� FK\ѭ�Q��`G;ԭ~P��T�yX�}G��x19�L�Ƹ�T�zR+�5{T�L	uv��_o���+�������d��'��џ"�O���o,�����O���U�ܲ��0kc_�q׮�8��Y�Ή�!�0�	�յb�u6��#�A����Ö��b��t�8��g�y3�!Hh���e� ��'� �U�V�쾐��T{V�^��;�ǘ�A�P�q���9/�>f���aW����0��0�^R73��Zyвۑ��cr�n/��4< �|@}����y�������>=}{�-���&����X�>c}�o��'�j�Ñ���Lp	��L�SƘS7��|!�X���/��@^���-�4���7jBD��;r���H́�hZ���^�����#��M����7�GS��W#�h�ο��vU˃G��`�=��{�l@`ç�6�5V�VSc#yK�����G����'�~r�q��i3T6yK#_b��}�j]����#�u+C��5��,`�=>m�w-wP�[@:*�S�]o�u��a���}t��O�ˈ�f��`v���3��D�E����vJ�E��g!B��
����H��n1�|��ԋpa��
^Cmr=��[��g�_�)��f���������%��q��A4��硇��|�P�h9�`�i�:�_���f+������¿ �!�?��_�jvZ�����=��\4�%�"S��ۛ����'��(Ec����}��e��R�scڌ��5b�^�ơ�z��������C7-�4��"�	�Z����AXG&����:�}���(L�q�<�n���@o�k�e�JB0�Ah@wL*T���4�;f�����X���k���ߘy���ъ;�1����9����7n/�5� j����j^7@g���%��)6��3sf�яo�d3�'X��dC�Q�3k���Q�W���'�/t��|n�ղ������N�{l���S�pM�kT�����.�� W���F�ي�&�Wг��̊�%E��X·qEE���ͯ�������٦
2~6���k�R�P��c�^/�^g��I�A�zOZ�=���ƨ�5Ծc���\}�����~�Q�h�vz��e��4�fɐ�<��maM�ji�֣Il�+����n��e������{�{����]Æ�|r����L��6MM����~k��5S|�<���������'�+>1f�OD<�9Y�'��|��G;��H���49���rC���0��[�)�(�K�/�$�t0����D5��e��L.���w��Wؽ�����쾟�c��5v��b���0�?��������d������)v�ݿ��p߲����nr�Mt��N�o��پ��ޠ)�����}�1>BSE��M�JS������S4��ꧩ���z�����4� M�OS�i���h_F_u�ԧi����h�I�����i�F��)M]GSt��Ki�]���Ʒ���`��k$o��<�|�a���'��OO�ᑍ�,GM�a�����O����)?�d�������׍�1������%�.�!!WL���ōdC��|�V�?����J�p�y�HD�u4y����#��������Z��H 葂���|p��O��Vog���ޠ���t�B�p!F��殎�P��������@�&IB���:���"=vm}�DC	MH���K�[9��5{��+��8J�|:;����zp�k)�ii`k!�]C�p7̻�\�ZL�d}��oL���Z��(��+"�8̗���0�	�b_@�0`�D��g�;~ @�  @�  @�  @�  @�  @�  @�  @���k���K��F<V���q\{��ȿ��Vķ#nE܍�nĻ�s(ޏ��O ~Z��s	#=��e����L�-�߰��5O=����=��}�Ox�q�+�V�/��_����|u���p���Η������\��<�n @�  @�  @�  @�  @�  @�  @�  @� rB��-�"���8嶛�e��(o�
er���Rr+��;�=���Ro�L�f�S�zz�n�?����y�;�;�$v��e��E	CMJ����zH�"�����W�~�7 }����T�~��%��rȗy�Z�;I.�J���-�.�nn�ɕ�+Jw(�Piws��W�;B��fh�MuJ���4����6+]������T���Y��Rj7ו+$�J������;;}�oN��l����z��R�m�b||�<P��y���ux`4f>ޛy=���f�ϳ:�(��fO�V`W�@��U'\��
(P������t(H���@�RnX��l����������U�
x�7H�����;��T�s�
7:xs]:U�#�q����dfG��h�����mg^�2���wnp�[�����h]�~�|���>��^Z4l��T�`W��u3-rV�)�2W��i��AkhL�L�PO�-Mޠ�竹�3���N�{�����x���W4�<n��*r���WÜ���t=�� �W�{�J���۩����3��xh�Z���w�� 	�
�'&�\���v����`����!1v�+�Os(�Q�=n:S��F�����bD�I]e�NZ���6������g�����9����K�My��Ĕ7|�F�B��.*�3NY��hąi��J�y�n�����<2vt�@M��Vj���$�?�.uKv�d��7Z������$%I����o�$&�M���z�#���B��ܜG��𼝷����|�r�!LbH(����Fz���8MVrz��Hߋt����#�o�E����#�܌���t'ҵH?�t���� җ�G���&�v�m�h�a���6�>��H�"݋��O G�wH�:8���C���~�1���x���H[���ۃ�
��H�"ݏ�?!=��q��x�S��Cz-��HoC:��]HK����Z��/{�ޟj+�����S�ޟ�Uz�W����J�?�*��T��g�J�?�j��8�������p����z������s��W���{��«��3�Z�?���8����{��bk��ӿF�?�k��3�F�?��z��]����z������t��j�~��y��xn�kH����.Gz�-HY9};�W �Cځ�=Ho�4��h��tm�P��2:�8�l5�ڹg�!���h�O�Dz�۫�G����������?p%��Fi�o����a��?{���~)�>�F;�z��4�H=�F;Lz�;�~:�~3��(OO_�FߙF�O�����F�!�.��ӟH�W������%���p}�:���j�K��.7\Mp5����V���./\_��W\��ꄫ��%\~����\_��B�hN�$qf"�;�M��������^|n��s�W��ѵp%��o�g�)Ͻ�Ӎ�n��d�}����p�r�=�M�Ym��jc=���o���E̼�>��v�]���u�}��u�7���z�kγ�������%�����ش�SN̲�����l��<�������(e�Oi�j��)Ԫx���eڤZ�'�j��Ν�!�!;�Όj2WK��L�p])T�q������F"s5/"Y�)o��|�2gbee�����zv�:���A�T�J����^��)	�����-����"�N��ls^ ��:�o�Q��7�FMy�;���d�΁��i�StwWG��xZ����Mg=�U(0?u�u
}>i�jEi�C� [���M�[�zs�r3<+�%�gjɖ��.�]nKւ�{+����;=P[����9�8��@25�+��8���t̺�[�vyK��l6kgh���-^(v�T��0I��-�5إ�[Zh��6���zE�f��8�(ĂJw��ڼuV*WCP|]�ms��v5��K+���@{�?[���U������ν�W�����rl��fs�aOdvAX��=٫��Z5/�
���.ȥ3\��]�*�-P��G�s��a��t��[��+:*���n�6CGШ#S��	�:F�W�ٮQ���36�����M'�Cڧ�TLɩ��SV9%��1Uj��r��v��w�(D�_0x;�}�ϪsY��n�������^Z�1��(/-sT�W�W�IvGiyU)�*ΥQ����)ww�rʁXkk>�#��B@�w���Pgs����sZ�Geyy��(�ƿ����_Q�$�}zճ����jթo�u`?}%y�o����-]!��%��x9R=+�~Ԧ
8�=��!5�n߆��Vo��N �=��U������>�U���j�4�g߯��ί"}o=����ϼ��ߜ��a����E���o��χN�yR�������}*�����W�'���#?xk���_�)�{;=��Cʭ���t�MJ���޼Ur��t�W�:9�_�j���v*�w�����C	u�R��f}����y��i�G���?G��B���K��綎��Y��*}�a��������on���S�U�v)	��
����������v�*ҍ����n{�F�F�����F���	)F\�x�{�F\g����@�b�����녏�/c�_Ld�3W�{	��OK+J3�����^�~��fesO��.�����?�#�`"�=��D��/��'�u�T�_��"����rQP�==�d9E����OշzAR��|���p�����#��3�s�l�f��t'!/�^EiknNyї�����|4����.�޸�~}�E}ېV�Sm��k�oL�޾�9�C�Y�/�n+5O���([6��è�1��%��̟d�NQ�(�v�����d�o�|���q}�K�F�YXJ�ZD�׀k*JTJ�A9�깒�{2�Ĝ{^4@v�u9shpEN�v�m?m)����ZV���P4wb�Ɲ�X���Cv��R >b��>�~+ W��M�+��V��W1%U���`�9�$�8m��&�j~$9i�{�V�B��*.��ȁ�Da��c�I�v��,��{��O�Qyk�}J1�T�V�5��8�(k4j;���2m�	�O�dH}^�Զ�t0�*�EԤx¤�1�}"���ܨ|rװ!"�����$�d�MS�]G�;^�,vj�#�"��H(��RLk���!{k :sE^����Ҏ[WZ�fc��Ϛ�o�!�VZ��>VX5���T�ari[���iU�-Cq-*e�J�-#���p���{����i�fO����`eǹ� �'?�2���2X���t�g�5�"�X����c1nD>8�����#�eO	+�h�c$7k@ ��2
�^�K]�;�:��db�HM��V��2�8���^Fn���e��x��m��a��=�Iq���Мa�O4�^nSJ���S��)�N�#i��5�N� 4��h�+��5*r�h����P*��(�/�c|��J��X���R���덚���t��9*���w{��7��GR}�'���*�� nVsb�����kWo�X�,H���s���Z1�:;�+yx����e���k]+���A���A윱���l�X�W� ���0���,�/��$՞���v�B��q�5w�ߣ=�9�+�]��{X�k�I��Y/eu���e�#���>��_λ ix �� �G�P�p���շgز�01���г���'c3�K5u���K�>�	t�sJ����,E�\���N)~6U�-�4��^5!"�vE�����xf/�vI�Ŧ��xdo�틱�W#�h�ο��vU˃G��`�=��{�l@�O�5�5V�����%b:�Q�,냤��e\sh��M���g�X�|_ûZ��/���e�O���b~��D�	޵�A�n騬N� ���C�fx4�ѩB֦E�'R��Ϭ?z�������N���,��h6���Iw�-�0i�A�4i5�&�g?�U�x���A׵���ɧ�K����4�Ox�y������/Hϡ�2m�����ef��|���/��_��S�'�r�,�K�a����#��;s��ό֯y�އi`�[���	"&mFUٌ1s�d��pb��4���M�3�G���Hh"*�V��4��:2��o'�����Ga2�Cem�N��#�|���#�ӂ
���1��0X���"o$xPjL��u��E�S�!��q{!��9P�o&�V󺭺x[7����:�F^I���B���:���"=v��#Õ��?a4�x�x�hx�;���r�D6���#S�)�aԴ4�K����v����׍�1���5��Cޒb����+&Pp��F���d���^]��������C1�݇��v����o���������L�W����^��|��]}������NMSC�#�᢯g�`����uK����ܝ�,���Iw�}!�D�#�H�n�CA��K�����F�xS��D��6H�cΧIf~s>��o����,�n��9�7�{�n|YqY��1�_��?���z�����?����b�$_B~[6��� �K����?/�j�xU��Wg�w#?[���e�(���4��k��k��# �����_��>�_�������V��[��_��?���Y���_��>��*k�$�g�ߎ�l�Y;M�F��+����4>_���7��l������>	�EY�v�);�о�/�f��·��l㣽4ܽ�z�k�<s���w��#oO2xT+�~��+�pZbr�i�;\��$�}g܏r��!� \Pn{���}��]�C���A��r�C�~��>�C��T�+�!w{���r����OOߎ�ANB��9�^�j�;/�� gG�U9�����!�䜧�� ȹP��r��\�����(����59���0���!w���A�[�C�:��G��r- ׇrW�{���/��g@�}��aJ���ryyI��r�]��l��r� w �V䐻'E_�~9��/W{���\��{yIɥ�r����>z����7����A���{䬿�rKrȝ�E(wm�b ��������V�y��֪�ע�j������/F�i��<]�]����e����m$��ڟ�̦����Վ��4�_��(�
�K��F����l�|!�,fC�=
vh�0�.�� o/f����X��Z�YmE,����I����bm����n!�=lo�=������>�]_�b�r��>9��M�FϥY���l�a��b�=H�|!`3�r��7�5�|>���b[���!l��y'�_�c���e�V��y,x��x9��y,���C�Yh?��y0t��W�BS�U�a'n;��y��|:��g��m�O�7ͧv屸�֘����<���<�ۮ�cg�جH䱣cl�&n����gb[$�� �	6��������i��ߛm/��amod[������b��J�k�9)���m#�w�����:(\���vD�����𳘿�1�����d-��p�%!��>Kx��/�������2�a�����}�[Q^A���Z�N~J��� ��c�S���1~�J�0�~�ač��a�Z,��|	1A<fB}���7"v"��cF,��qq#b'b	1A<f����7"v"��2��`�ԇ�����\�;K�	�L���q��k�U�>b�>�{�Ey�=�̀���&#�ӄ�7��H۵s������dJ����k��s�}���\.m�_���F!�3�:�/A����;�~mW��h���v���&�O��~[;�_k�vᾺim���\6���pi���v�_��h���ھ�}�G�Gim߼��}ؾ2�1��E��O.��Ez������O��^�|m���>����EC��k�O6����
�\,��1qZ��n4sZ{/��e1��{�5���u��(���3 ���;\�ˏ���?/���+�M-=-��?&=}�<=�N����YO?n��?���I+��4{z���e��O����Q�/_O��_K���4�v��.Mӗ�<�Y�������$r�~��q9`����a*9/9����Q���yj�i?D��3�����@s|�K�S2fsdV��fs����!~�=��{r����|��`p�'��'�3:�+�AHi�襞���gu��G} ޔ��fy4Ӭ��?��L��}9Oۘűs�;���' Ӝ4'��D�3=d��s����p�)'-����>.'m��C��� ��W�}X�,Ow���������~�ft(P��23P@ @�G
�|n 2 