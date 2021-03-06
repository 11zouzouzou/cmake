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
� ��gb �}x[ŕ�H��v"���Sr�&� J$�;!�4�Tib0��&|�ײ-�j���T��kE$�v)_
t��|-���e�ۂ�@���KL����iz���R궼���9Wҕ%ى��9_�=s�9sf�ܙ3�W�fo�r��n�WUTHWrl/-�Ar���9��+J+���t���|F!��`�=ݡ�r �֖���H�h��o��^��|Ցs��0�)�_^�_VV^A$��2(�����?����L�6�U��B��?�����KQ�6|B�]�v�t�Y�C����y{C��δH�� �%��&���^�����$���7��SIE	Ć���{8�����
t������ϠϺ��?�Bs���Ңxz[<=A%�nNק��C)�N_(JK ��v�gi�7r}�)t*��}�]�`
�׷�&�OJ�M9�u���jU�]m��U���:W{��dz6mhؠl���z�͙�wi؄������)n�U�J�ԓ���%�.5�'�N�+��.�͊�s+�]���>�'�Ϫo4�N��>WW������ۙ��P_G
�{�� 9l�|�y�fm,G��9K��@���2�܎rf@f�M��� 8~�0C��������j�qB��O���u�s^�p݁���
�2�/&ܷ��Z
�����kZw�Z��������_Xg���ɉ�r)��m�LE,��f�>㵄���Wa���g�@�c�'
"&�5a\-�]�ڱ��63�������t��]���s�Ǳ��ў���W!M�W�  @�  @�  @�  �l��9���f�q�=JF�&]�P|wߤѲ�B�+�~�e�qWԮZ.�t�k���n89L��PO\���S�) �B�z�2�K_�e`jB��-��\yP}�I�B5*�DB�f��a��	�Q:�dZ�ĳD�����/��R�����u�0�+�wX�ʟ�������}c�.�YVy��4���.f�U.��CP�O���sY�V>~�fڋ�����c1;�ߥ�����I뜠_Ёa���c��σ��BȌ��vk��<X:��C��ȲtO��H.�tE)�G�T��иz%��hh�yNuQz�1i��m�5]��NM�5U�TcD�;��,�����2���U�ar�t��>�GY�q�p\��YTB'~��� [F�����X�ۣ���l����s���4�fNB'�T]P�6�'�_Ð��O��}�Ӈ���c�	s9VdH]�ǈxz�hGV� nD>�TD�C+,{K473Q/�N��  ���^�K]ѻ�:��db�Hm?�VO��ʽ_����G���1r�ex,;�c��kT�k�푽=Iq��#М���-����M)��'�Ϙ��&vpG�4�xL��s	3hLu\��-qE��FEN�P��^	�R�`���c����`�3�R��)����1�%��Y���j��L:@[L�/�+�%��X�nB�p?�g�n�9��B�?1�?0V!�Fp�ړ[��M��'\���ĲwQr8''����'�TתQ���޷�����7�Z'�X\ċ�vȵ�((�q\�̈́� �e*$���_��h#�~T�:yв�b^8NR�Ym�zmw���c��,Í'`�;�缰�5��W�"���އ�e7�٘���ј٭��C�=�6���t{%��X��A��S�|��s�8���-����;b�S���79��gǳ��8�C�>�\S����FgʀKH�v�2Ɯ�1����Z4}~�4��G�oQ�Y�ݔ6�Q"r\ݵ���Gj�G��g�
l��D�A�lh�G�Ű��~���C�t��յ��X:�=�쉄�af>�?��m�:���[���DL�?�\�e=�����kM����ۚ�*K��o|[�r��UI�[�����OgC��h�k	�����QY�6?�~Ӯ��,��h�S�|R]A�5��$�s��Uo�]�%�C-J40�}u��/r�=��BT����Djw�1���l�^���V���9�ت�g<C�bLq\5�D�&�_'��//���.�I� =\��s�:�H˹s������<e1CX����$��<���s��!��:V���e��/�i�7ࢹ>����ތ���?I�E)���]��4��-�e���fT�ͨ3�J6�'��ߛ�ʾ���ie����	MBԺN��4��:2��o'�����Ga2�[�1u�B��ysFYs,�T��NB��ZP���.���q��X���#��1^�5����C�T��V�Y�1$�W̙���q{!��9P�o��U�� :3ί.���N���ԟ�3��~|�&��?�:�'���7�Y�`����¬M>	������#m�Հ��P4wr�k`���B�k�]����Z��p��/�'5��V�6i���U/dVT,+��2��+*�e�my$_��T��6U��<�T_Y��������B��U>�����T�e���~j��[C�;��o�����oL��&em�F���;^�M<I�i����-��Q�t0���h��f��ڮ�f�[�j���נ��ݜ�=b�ȧ&>	��$Yo��$�Y�f�_3�'-���,?->y.?k|}��c��D�#�㑕y"�ȇ?y����/ΐ��/�4d�/�㋿%�⋒���"H2M�_�JT�Z�H�Ԋ�}�����}�?���=��_f����av?��c����>��_g�C��?��0��ݟd��� ܷ���wm��ZA�S���dvl���h��xv�'4E�kL��T}�1LS����h��h�4����K��z��v�ԃ4�M=@S'h����XA_u���i������i�	����gi�f��)M�@St�&Ji�m���ƷS��`��m$o��<�z�a����'��UOO/ᑍ�,�L������O�c��)?�d�����W��k�w5]�yˊ]CB��@��K�����ҧ<����K"�Ic���Y+�+������3��{$wwP�n�7 ��G
3�n���[�?��ڼ]���K�vy�^�O���y$�[�;{BAoW;h���vś=$	�8^�|�����M�	���%4!��_�].%o[����%�g����(M���XGW��Ѯ#�������e��xl-!>�=0��{#�}h1���|8��Ӏ0��kdBh5��R���0_6�8l&���!|!#�������� @�  @�  @�  @�  @�  @�  @�  @� ����/!��x)�P�q�u�#�F�.��߁�q�{�AL�=�� ���Kp��/"���gsnA���/���#�����1�=G���9���o��������MΗ����]��|��C}|������s�f @�  @�  @�  @�  @�  @�  @�   '�,3��1�tY�SQn��>X�(���PP&��I,%��%��ǳ�E.���$l�<���W����]n�7�K��Nb8[w�Z�@0Ԭ4{�Z=���(r8Z:�~%�w{���px�T�]A�ꗽ^r[`I,�|���M�����y�ڃrݖ�\i���
�v�=~%�3��j�v�R����F�˚�o���=���J�]���*�nK}��I®�J�=]��s�G��TM����kii�:*����!��7@. ��]w�@(�<�P�F#`�㽅�S��nq�<5��Gis�x������:�jow@��=�� �CA�Tr�r��2oW{殀���V���VU*�� �N��z�Tv�P�ι+����u�T��D�A+Ǔ�ug_���
t𺷟}�ʀ�+�ߵ�!o�/S���sV�uA��k��VZ�眊ziѰA7S�ݭ�-��9��\�\�_���13��e@<AH�6{������;��	v�����f._�����g��a.R��9����zX�A������fO��K�[:(g(��К��<��06�OL
�����"Ձ;��w��C"&b��P<���PУtx�t�.���7B1�%ĈF����]�h+�c"y�</}�8�����43��$?4����)o�6��m�I]T~g��j�ш�-�)(5�[��2�A����б���:��Γ��<��#٭����d�JVk�S�K�h�$�6P΀I��d6A*����|B�ssEZ��v�@���Y^@�U�0�!}���m�~�q�.�4Y���H� }�1��e�?���!��B:��J3ڻ��]H�!�4�a��҃H_���s�Hۑ��}H��@�\���v#=�t��H�8ҿC�����Xҏ"=��;H�#ݴ���^Eڊ����W!�D����	��O m�s��,h��Az;�q��FZ*��o�J��+��TW���p�ޟ*��d�����J�?MUz�	W��g�J�?�Uz��V���Y���X��F���#����^��g���j���S���p���k��#����s��z���'�V�?k��3�V�?ck��c_����uz��Y����:��H7�����(�G���v��4���r�'�ފt���w }�>�Hߋ�&J���9M�6��w1�É��j���=�i����F�|�:�#8�^c@>ҟe����̟�����<4J�}�hߗ����6h�i��4�a�����G���4�a��=i��i��i�%yz��4��4�@}(���4�ita���H�:�ޔ��߭i�p��3p��� W#\
\Mp��j���V�<p���ק����9�|puµ�.��i_�凫�O��Y��$t����KA"g&���ؔϸ��n�����g>{pE�]+,W�Ax��|������y݈��|^6���>����s�d�����6������;�[��{�s�l��eO�^g�WO�Pg~é�����<������	�\����͛���,��ܮ�f������ne�~�R�����`͡6�=�,�&�J>A�W�t�L�٩ufT��Z��e���K�ʌ�$<��� 6�5�4�d�������˜���mn��Ӫ���w�S��*->wW;x�ϧ$|8s����&���;q���y�.�@�ypFm��25��;˓�:���-NU��ݝ=~O �i���7���W����#�W(���e�������laT��v�~��ʭ�����%[�ں�w���Y�R�a��{:���@mm?����X�����tZ����9�n����v6�٬���
�z��1[ź�P$Ջ�:��`��nm��n���-b��3〢*=��{�i��9��� .������C�8j �7�V:j��@G�?[���U������ο�W�����rl��fs�aOdvCX��=�5��m�n���\��Y.�3��V�Oߣɹ?sf��`x�t{�����DpJ�w[�#hԋ�����`�	#�+�\רDl���a[����!��r*��TO�)���U�.5]U9Ŀ
�|{�޻h"�/�]-�P�g����n�WUTHWrl/-�Ar���9��+J+��QZ^YA���i�!xD�`�=ݡ�r �֖���H��ƿ��9���¶zuǼ��QY^�c�+ʴ�/�,��_Q�$�}f�s����f��o�q� }%y�o�}�+����!��%��x%R���}Ц
8�=�!5�n���6o��N 3=��U������>�U����f�4�w����ί"�o<���CO���ߜ������9ϩ�o��χO�}B������s:�����կ�G�����2�@��`���H�)��M��[oQj7|��m�#���[@�^�fͩ�Z�PKw]���ӱ�S���WN�h�����\�t��5���|^c?
g�9*v��@�.}���:r��e厪��e�.���>z����qc��kJ�R���ʚ��I��; ��|,�ʄtS�����Q�I�Y��u[����C��FB�W!ގ�>�g�8�*�����~��a�z����_�Y�̕�^�d�ӊ��~�(��W��r�Y��ۻ�[��|��1�~�F�7QD�����M|4�s�Ĥ��\hOo0YNQ�����,Jꣶ����� N�Ss$_uf}Nԃ� ۭ���$�ի(�--)/���5�>ҽ֔��2��пܥқ64lH�c�o;Ҫu�Mz}-��i��۷r1��H;K���m���)RB�e�T~�5�s|���������i*�ӡ��ݝ����_ȱb��o`~��?K@)\K���pME�Ji�a('S=Wr�b&��s�����."g���i��7�g,%r���6�j��Q��NNx��3k�uõqȮUY
�G-�O���a�
�H�IsE��*\�+�����Q�"Ǒdg,���]-/�$'�y�ҪU�\D��19��(��u\>E��S���Or��1*o�O)�������'em�F���;^�M<I�i���Ȑ�>ʚf]����O�9�����O�1D�S����b���ijҵ��}��Nm|$W�o�	�]Q�Q�i�}T;d�c@GC��s��}L��|�j��=l�S�YS�M5�A�J+����k�fWt��2�B.m�0�8�ʸe8��A��"QK	�e��aYN���o��@"���I����������Y�>����^��N��Vd�c]�3�v�aƍȇ&x�Z1H}dR��-aŠMt��f-�p�SF�6�ˀ@u�+zPg\���L������ʽ_�a��~���M��Q��0�����Q9�~��')�Ҡq�3������mJi�p~�1;D"�?��&Ӊ�ƒ�-qE��FEN�PwR�A���c��y�`L�sS��t�X�X��IӜ�������a4Ge޷	�#��n�9���r�h���ĸ��X�`���jOn�6�מp����E�᜜f#��P]�FYg'z%"oȵN���v�k�QP<�=�<��3��2�ˁ
|`�����u�e�żp��ڳڠ���!(�=��C������{�5gaz�+�l/�}m>i�1녬n�N��qd���O��+y�"��0��(�j?��A�����X�&Fݛzֳ�Y�d|6}r���1y!�g�];�NcN	����(u��8���!�Ϧˣ�E�f=w��&D�x®�?Rsp<����aI{��4���a{��1��rdm���V��jby��L�'z��H�����1�DL�?�\�e}�����kM����ۚ��K��o|[�r��Sס��=�Y�O��6����;��- ��i��3:{�����~:U�ڴ���d�����G_�?R�ھ�i�9ʞ����Q��f3�6鎱f#�;D�&��������j��п#�61�:�t}���w���	� =\�>ՉE�9t\f�?��1C�����$��<���s��a��D�V.�e}�7L��xD�|g�����"o��0,t˰5AĤͨ*�Q#f�lOΰ���ie����	MF���ɓ��!XG�����:�����(L�q��M�ɕut�O�T�o��ZP�[�O>n�����x��J�k3�ο�hz�0d�7n/��� j��Զj^�Uo��W�TTK���K)ՐT����r�#_��]��o�z�a����'��UOO/a�5Y���#&X�d�?m2�����vij�PB�����|��.gM=�Ȑ���e0$�	\���l�& ~����~�woz���#B���P�zip�l�R偃&���~�����w�P֡>>P��bf���1���p��3R�[���z�6�QK�.�~�u���ܾ�G"\�k%B7� l�%�ZF�n'P�9�{��x�$0��$3?�9�·��}G~���ě�=H���"K��/��D��F���P�X��R^{�T��/!�=�}r�?���Y�q�_��o5s�&߉�k��{����ȿ:���CZ��uY�u�ߙ�?���Y�#�/�f���P^cd�ߊ�mY�=�/��D��,�1��f]��}��oG~6����|��\��z����G~6�f��a����,|;�?�f�3h� �e���g�[QO����	��F�V��x�9f��;���7�<��ܰ��E��E8-19�´�-.�q�]��3@���{��(�#��3p�����!G�����%9䊡���r�!Wr*ʕ䐻#E_{9���gfnǓ '���r��\5�]�C�=���ܚrˍI}���
r�33�_�\(wu��@����~u�zQ�ro�\�v搻�D��-�!w��\a�V��G��r�=hJڗK�S �1�^3%�o[����}e9��K�wi��;�r�r�ݛ�/W�Jї��?�K�_��蝼����w%lfGfa=K`hϛ�ga�C w�r�=r��r�e9�N����>�\1�os�ە���me+ƂGik�֍�QW���`�L̗��4}T��ͮ��l�������t�6�l�OkfSv�����y���/�d�_�%l�l���oo������O����;4[q7��w�v��Y,e{��Ŭ��"����(�E�o����XLe{�������v����
Y��n,d1�m%���Z��&m���,��B�ǰ�|)�^�7 ��p9�ߛٚo� ���cf����������/�`��"`+`�<�n�p�S�&��,��
x�|0t��W�BS�5�a'n� ��y��|:��g��m;�O�7-�v屸�֔����<���<�ۮ�cg�جH䱣cl&n����gb[$ۗ�	6�����M��i��ߛm���amod[������b��J���9)����m��w�����:)\��Z�vD����������1�����d��p�a��>Mx�o^�/O���e����`9?��ʷ���r�X������	1A<���� x#���������È�o�ruXΉ�b�x܄� #nB�D,!&�ǍX� �0�&�N�b�x܀� #nB�D,!�Ce
&	���!�� �(C�0�7!v"���|m�㤽��s��}Ĥ	�}��
����{���}�-F<�	�j呶k��!}#=�ɔ|�� ���h��i����\�>�2ύB�g�9uH_����w���>����5!�9,�l�����vҿ����}u+��>��ڹlH�������8�������'�?�}��h����$�ھyA��}e�9bH?�|m�\�ً�F/m{�������>�Y�}�/�����t����l~O�5��X(�kⴶ��d��^��e)��{�����u��(���3 ���;R�ˏ���?/���K�M-=-��?&=}�=�V����YO?n��?Y��M+��4{z������O����Q�/_O��_N��4�n��.Mӗ�<�9��������$r�~��a9`���a*9/9����Qs��yj�?D��3�����@�|�K�S2�rdV���r����>~�=��{r����|��`p�'��'��:�+�AHi�襞����t��} ޴���x4Ӝ��?��L��}9Oۘñ��;��' 3�4/��D��=d��s�Շ�p�i'-����>,'m��C��� ��W�}X�Ow���������~�fu(P��23P@ @�
��F 2 