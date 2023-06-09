PGDMP                         {            icwsptef "   11.18 (Ubuntu 11.18-1.pgdg20.04+1)    15.2 L    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    27862541    icwsptef    DATABASE     t   CREATE DATABASE icwsptef WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE icwsptef;
                icwsptef    false                        2615    2200    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    27            	            3079    17135 	   btree_gin 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;
    DROP EXTENSION btree_gin;
                   false    27            �           0    0    EXTENSION btree_gin    COMMENT     R   COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';
                        false    9                        3079    17680 
   btree_gist 	   EXTENSION     >   CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;
    DROP EXTENSION btree_gist;
                   false    27            �           0    0    EXTENSION btree_gist    COMMENT     T   COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';
                        false    5                        3079    16661    citext 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;
    DROP EXTENSION citext;
                   false    27            �           0    0    EXTENSION citext    COMMENT     S   COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';
                        false    16                        3079    17577    cube 	   EXTENSION     8   CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;
    DROP EXTENSION cube;
                   false    27            �           0    0    EXTENSION cube    COMMENT     E   COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';
                        false    7                        3079    16384    dblink 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;
    DROP EXTENSION dblink;
                   false    27            �           0    0    EXTENSION dblink    COMMENT     _   COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';
                        false    22            
            3079    17130    dict_int 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS dict_int WITH SCHEMA public;
    DROP EXTENSION dict_int;
                   false    27            �           0    0    EXTENSION dict_int    COMMENT     Q   COMMENT ON EXTENSION dict_int IS 'text search dictionary template for integers';
                        false    10                        3079    18303 	   dict_xsyn 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS dict_xsyn WITH SCHEMA public;
    DROP EXTENSION dict_xsyn;
                   false    27            �           0    0    EXTENSION dict_xsyn    COMMENT     e   COMMENT ON EXTENSION dict_xsyn IS 'text search dictionary template for extended synonym processing';
                        false    4                        3079    17664    earthdistance 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;
    DROP EXTENSION earthdistance;
                   false    27    7            �           0    0    EXTENSION earthdistance    COMMENT     f   COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';
                        false    6                        3079    16650    fuzzystrmatch 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;
    DROP EXTENSION fuzzystrmatch;
                   false    27            �           0    0    EXTENSION fuzzystrmatch    COMMENT     ]   COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';
                        false    17                        3079    17007    hstore 	   EXTENSION     :   CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;
    DROP EXTENSION hstore;
                   false    27            �           0    0    EXTENSION hstore    COMMENT     S   COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';
                        false    11                        3079    16889    intarray 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;
    DROP EXTENSION intarray;
                   false    27            �           0    0    EXTENSION intarray    COMMENT     g   COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';
                        false    12                        3079    16444    ltree 	   EXTENSION     9   CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;
    DROP EXTENSION ltree;
                   false    27            �           0    0    EXTENSION ltree    COMMENT     Q   COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';
                        false    20                        3079    18315    pg_stat_statements 	   EXTENSION     F   CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;
 #   DROP EXTENSION pg_stat_statements;
                   false    27            �           0    0    EXTENSION pg_stat_statements    COMMENT     h   COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';
                        false    2                        3079    16812    pg_trgm 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;
    DROP EXTENSION pg_trgm;
                   false    27            �           0    0    EXTENSION pg_trgm    COMMENT     e   COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';
                        false    13                        3079    16775    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false    27            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    14                        3079    17571 
   pgrowlocks 	   EXTENSION     >   CREATE EXTENSION IF NOT EXISTS pgrowlocks WITH SCHEMA public;
    DROP EXTENSION pgrowlocks;
                   false    27            �           0    0    EXTENSION pgrowlocks    COMMENT     I   COMMENT ON EXTENSION pgrowlocks IS 'show row-level locking information';
                        false    8                        3079    16619    pgstattuple 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS pgstattuple WITH SCHEMA public;
    DROP EXTENSION pgstattuple;
                   false    27            �           0    0    EXTENSION pgstattuple    COMMENT     C   COMMENT ON EXTENSION pgstattuple IS 'show tuple-level statistics';
                        false    19                        3079    16629 	   tablefunc 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;
    DROP EXTENSION tablefunc;
                   false    27            �           0    0    EXTENSION tablefunc    COMMENT     `   COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';
                        false    18                        3079    18308    unaccent 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;
    DROP EXTENSION unaccent;
                   false    27                        0    0    EXTENSION unaccent    COMMENT     P   COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';
                        false    3                        3079    16764 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false    27                       0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    15                        3079    16430    xml2 	   EXTENSION     8   CREATE EXTENSION IF NOT EXISTS xml2 WITH SCHEMA public;
    DROP EXTENSION xml2;
                   false    27                       0    0    EXTENSION xml2    COMMENT     8   COMMENT ON EXTENSION xml2 IS 'XPath querying and XSLT';
                        false    21            �            1259    27862557    Company    TABLE     �   CREATE TABLE public."Company" (
    id integer NOT NULL,
    about text,
    directions text,
    address text,
    tel text,
    operate text
);
    DROP TABLE public."Company";
       public            icwsptef    false    27            �            1259    27862555    Company_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Company_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Company_id_seq";
       public          icwsptef    false    223    27                       0    0    Company_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Company_id_seq" OWNED BY public."Company".id;
          public          icwsptef    false    222            �            1259    27862593    Employee    TABLE     �   CREATE TABLE public."Employee" (
    id integer NOT NULL,
    id_chat text NOT NULL,
    competencies text,
    duties text,
    photo text,
    full_name text,
    achievements text
);
    DROP TABLE public."Employee";
       public            icwsptef    false    27            �            1259    27862591    Employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Employee_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Employee_id_seq";
       public          icwsptef    false    27    225                       0    0    Employee_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Employee_id_seq" OWNED BY public."Employee".id;
          public          icwsptef    false    224            �            1259    27862604    Office    TABLE     Y   CREATE TABLE public."Office" (
    id integer NOT NULL,
    plan text,
    video text
);
    DROP TABLE public."Office";
       public            icwsptef    false    27            �            1259    27862602    Office_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Office_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public."Office_id_seq";
       public          icwsptef    false    227    27                       0    0    Office_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Office_id_seq" OWNED BY public."Office".id;
          public          icwsptef    false    226            �            1259    27862635    Product    TABLE     �   CREATE TABLE public."Product" (
    id integer NOT NULL,
    name text,
    age text,
    "time" text,
    cost text,
    about text,
    type text,
    skills text,
    subjects text,
    teachers text
);
    DROP TABLE public."Product";
       public            icwsptef    false    27            �            1259    27862633    Product_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Product_id_seq";
       public          icwsptef    false    229    27                       0    0    Product_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;
          public          icwsptef    false    228            Y           2604    27862560 
   Company id    DEFAULT     l   ALTER TABLE ONLY public."Company" ALTER COLUMN id SET DEFAULT nextval('public."Company_id_seq"'::regclass);
 ;   ALTER TABLE public."Company" ALTER COLUMN id DROP DEFAULT;
       public          icwsptef    false    223    222    223            Z           2604    27862596    Employee id    DEFAULT     n   ALTER TABLE ONLY public."Employee" ALTER COLUMN id SET DEFAULT nextval('public."Employee_id_seq"'::regclass);
 <   ALTER TABLE public."Employee" ALTER COLUMN id DROP DEFAULT;
       public          icwsptef    false    225    224    225            [           2604    27862607 	   Office id    DEFAULT     j   ALTER TABLE ONLY public."Office" ALTER COLUMN id SET DEFAULT nextval('public."Office_id_seq"'::regclass);
 :   ALTER TABLE public."Office" ALTER COLUMN id DROP DEFAULT;
       public          icwsptef    false    226    227    227            \           2604    27862638 
   Product id    DEFAULT     l   ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);
 ;   ALTER TABLE public."Product" ALTER COLUMN id DROP DEFAULT;
       public          icwsptef    false    228    229    229            �          0    27862557    Company 
   TABLE DATA           Q   COPY public."Company" (id, about, directions, address, tel, operate) FROM stdin;
    public          icwsptef    false    223   �F       �          0    27862593    Employee 
   TABLE DATA           g   COPY public."Employee" (id, id_chat, competencies, duties, photo, full_name, achievements) FROM stdin;
    public          icwsptef    false    225   (H       �          0    27862604    Office 
   TABLE DATA           3   COPY public."Office" (id, plan, video) FROM stdin;
    public          icwsptef    false    227   �R       �          0    27862635    Product 
   TABLE DATA           i   COPY public."Product" (id, name, age, "time", cost, about, type, skills, subjects, teachers) FROM stdin;
    public          icwsptef    false    229   �R                  0    0    Company_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Company_id_seq"', 1, false);
          public          icwsptef    false    222                       0    0    Employee_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Employee_id_seq"', 1, false);
          public          icwsptef    false    224            	           0    0    Office_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Office_id_seq"', 1, false);
          public          icwsptef    false    226            
           0    0    Product_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Product_id_seq"', 1, false);
          public          icwsptef    false    228            ^           2606    27862565    Company Company_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Company"
    ADD CONSTRAINT "Company_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Company" DROP CONSTRAINT "Company_pkey";
       public            icwsptef    false    223            `           2606    27862601    Employee Employee_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (id_chat);
 D   ALTER TABLE ONLY public."Employee" DROP CONSTRAINT "Employee_pkey";
       public            icwsptef    false    225            b           2606    27862612    Office Office_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Office"
    ADD CONSTRAINT "Office_pkey" PRIMARY KEY (id);
 @   ALTER TABLE ONLY public."Office" DROP CONSTRAINT "Office_pkey";
       public            icwsptef    false    227            d           2606    27862643    Product Product_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Product" DROP CONSTRAINT "Product_pkey";
       public            icwsptef    false    229            �   �  x��QKNQ\�)z����� Gp�3p�j]��������
�7��?1��y����J�Ȱ�NGz�]��F�Hǂ[�a����/x��x¤�L	ݰ�v��u kW�$4EBhd	�A����+�W�ަb%H3,ɓi�=S�f����E�xG�%��FV%�S��	�_��R�s�)_C!�Z}zdFE���� q�u �!�@�[�q��(,����4bίam9��D�U��rf�ӁW��+��ķ�B��;��±�8G���&:�Xc��w��ͩ�Mm�V�Ӝ����E��j6p6[<�e��_�!�Z�G�������5|vY���}���O���=/�h�l^�eLg(g���Z��K��kA�N�HJ��;��e3�I��g���d�A      �   `
  x��Z�n����b�+��J�ԹR�1���67�a$:l� E��d��#�qilIvQ(�(��"E�̾B���|��r�\�.�E���f������\n.��_� �ہ=�={A?�n�_}X�M/o��!�}�>�v6m�z��Ѐa�$ܣ&�^���p��8�OF���Q��j:���/��fi�^��7�f!7WX�QK�ڨO���p����040�{��0���q�
whV�)���6�qa�54�O�,'��ÿВK5C���y��R,��7���MÓ�t�:�g�Y���	�!����Ko�������8��X?^�Y�����yV�����h�J��D;Y�ǝ�̢��9�T�ivj��h%��F�k��q�ԝ���	�������0��q�p��9,�pUO��`��47Twa�e��m��8��/��}�}NVY`�U^(�����'<���l�D�{v��gsa���D��ש%֓��!)�xf�w�D�vؤ0й:��&dC���xh�n^���	�&q9i��h	��1�k��<����� 4������)��}ӆ.�K��q�<�:�%bcӻ�����7�m���Ҷ?�,ްj����鱗�l�{W��ձp5KH�����g�Tu݆cE��������kԒaZ:�a��g����x����5�X�:F��,��fG��"S��!�K�K��w�/���Y��R��Pj,��0%��Pi�5([9�y}zy!iLL�GjaЅ�8MA��ԢD�-�>g��bǢ��$=c[�i:@8���p'7k�KZ�D5=�3IVC��Px���3w>(~\\�?;���_�b4� �j!��Г�לK��z��$TwmSL]9����&3�18������%
�t�e���JՉ=NA"����=T�Ȳ�����J�6C L��Ň��ji�Y��i>)��)���GvTXg�v��ꉫ��T\*�xX2�{f��E���	��s���u��QPǩ!��||�����d%�(E�(�/����uY�)�2��c�fZI���6�" �y����(���N
6�Z:0��yf��V`�H&-�H�Ŭ���djK���r���4D��T[١]�$	�ic���D!�!lM�I���0���ry��C�����N�z�X������J���R`�2�ߘ$�����0�:�d?��Ra'���K����U�!��D�թ��aq��i���*�ӈ��Bn���wv��D���H�P��>�M�!�}�z�R�-�=Z�!�ܤ���i���)s�ߚ$c<��O�x2����x��6�,����m�C��©���CT�9�3*Z�����\�F\*ޤ����)�M��i��y��Z��D�3 �1*H3����.�T�X��H�������$��24G�<9-9�>�x�
f�r�	{����������%��Z�V�\��̓���j�V��ͧ���z�Jo���Y�W+U�G��Vj�f��Z�\��KŵZ�R�0����b�d��Dg�?|�x�,VW��W�����ri�h����o7�ys�~���V0�@���7�~��`Dބ!8H���
ti�����������B��!�B�D*2��s�j��F���\_G�x�m�O8�
p{0��l>}Gj�E%��JF����%��#P�� |�6���`�+1~�F�^�pw&?V�H�%4�J�<ݗ��qYE�
��WIl#�y���$���wSg��31\2ڎ�˰��e)GV�8��X�[�r�0�� }�7���Ow��*�~�������x4�.Y������(��M�O2������0 �#��P�zaK�nh��m�9�~�AAY����p�	q-ƶB��H��g��%��1�i}������%�I��;ȏㅱ�Xm�ܾ���'5T�Ge�H���i���7"�$ϩ+D����w�a���]Ǝ�h����M�#K{Jƨ�F'q��^�/��M����<Vt@�����}f��/��>����qβ�kY���wV����N9�6�6r�T�טC�CL�or�
���m[���޴F�q��D}��ɃCO����1�?DR�~t���T�P�T5�U�k��<�꧟������o�@qO.����˙����g��gŦ���<A�Y��Z�';������.;��%��=ǒ���|
��T����R��nF2f�ߎ���es������@m�W{P0�͊*��系.>1�����������
3��0u������;m{H�$��O���0rZ6�#F���\��qn�
����ka�S����1�t;��MW���;+�bme-~���nߝ�S+Vk�>��t��m5��f��̶�z����]X�}���L0�m6�ؕ�k�!�|an�6jӡ�<s��i�:��WG��ݴ��'���wf������/"��#�F�t��X�Q����0��dI��~c"����m [L�h��9���M`_����ND��@.=���zq*/t�YS�W���-Nʊ�n�l��+_�|_�%��=���4}"'6$��5���q�ː]F����M���:H��~�+��x�ħR������� ��      �      x������ � �      �   �  x��Z�n����b� UK��4�*�u�� �����P�*dE�Dɪ䒑��� ��h�"�Ҋz��W����ٝ�R��4�a�"gg��9�;�w�K��6֟6[���t���.��V�2}���tbf��ݻ&�i��i����4J��_�$���l����l�>���(ѿ��R&���t�Ѵ�a�]��t��y�|�u�}C�L��l��}�ט����2�>0x��>IȪ$��E�ʀO�U��D��i/�M���K�V'�[I`�9-pI_ae�#hbZ����>���E�~]�2�sπ6b��!������fp���d;b��>-r�˄�������Qt�=�l�C�zi\3c������b���i`�ņrּ2���S��g�3��P���/��z�/g�g+k�e�W�A�����B^�G4�K~<�A�*�"������#�.�ΏD���۞�s8�o��ؕy�.Ƒk��g�n.�~���n��q��J����v�
[���o��Kz�ÙfϺlX_������obwցe�F~���dҸ�Z�EN1/�D 9���Hj�7��cxo��7�p�m�$��
O�RC2A���3d{ّ������8�$;j���}������s��O�32�$%d��&pf���g�f����}���iء�G���i�@��=Ύp��?�D]@|��dm�ل�8gg��Oh��
�%S��p
��S�<�;&Ā#R�.�&C�_v��ж��Ƽ�@<����1�[�8��f�f��&ڣȁ�ި���(���<��br#�F[�D�Ĕ�����5��W��'|����G�l�m�����ͭ�f�N�)�$��G�=>�+R̷#U�>5|m.j�����z�V�g������6�*u'Ms5��m�sn�݂�����ؾ]��j��
؀�k���}wkJ/�tm�a��bV��0hw7�o�&���5ͥ =���p�X"~hKκ=/
n2+^�
a+*���~�'�q
�D|b�nI���;.%j���w�v�`����
K[��.�a�w,�1���Fu��
}�p�|�"r�ho����Գ��uvt�� ̦ɛu�P��OJޮ��?T#�!�}DL-�;Ò�nv��Lnw.�G��"t�f!3�W��'��%��ǩR�"Oó�ɻƤ_1�c8�H}���_ؑ��T����v|ʕP���k�O2�k~BAnb������b��Y�e�`*��"c�؅嚠q�獥�*�j��G�5���5TBp�&'�5�}v�:��T=,�qM8z� �%˦��:+��r0s2:۫O�8M+"�ĳe�T��A����3�$B6cRg�|duP��x ��3��L:�3a��2pb`�?[�$��1�����bJ#y Lm->�����`���k�H���
u�:�^z(!�K�{����d�@��@x���+���s��ǖ�-��s������IΌsJ��U�1�\�^a)�\�"h�*����y���<�2jO��u�f�Qf\'$�lA��3�J
�s�no%D�g��7>���և����YX����>��eZ]������ic���X���SH�����Q����N����H�b���J�C�-)���J�[���N��h�`e�/2� b��J���� Ͳ��b@^0�����:���Y�{H㸍%c�>�U�-@�ٮ	�F����"#���3�D9ٻ$U� ��9 ���P��D�*�˕PYO�3?��1�)qQ��צx���<0$	�na�Πl��9f��mYʱ��՞FŬ�Ӆӟ��5�w�(���
�e�o#�Wb�\ߝ"%&Lk��2�v��M=��>jf)͞��*i��.8��)e�٦�'%�`�}���'��D*'!=���&%�.������/̯�>l�_�x�*�h~��;���u,�l.'� �R&ܷ�����u��!0l�@�ʂ�"���b�/(�J�B���ypV�(�8�I��x`�A�A����]�y�cR�y�]0�Rz-��1�6%�A��8��C	>"�PӠ�|�V��=Ⱥ��)s���ܚ@~.\��F=��̘�@�r�R_��~�qó&@5¬$b{�L��Y�uqa�.��k�V���M9/̛�d�/<\5J�� !dZ��d����r&2��%U��3�2��t��qԄ���@ �ڜ��N��:r�ڋv�藿m�r�J��ސp�}.��tB�u{��{5�r�[�����J탍��'�kKK��e���l������n���������$�������h���g�ɾI�_�D���Fld����,�nֈ�S�$��XD�w��Hw7R�p�ɝcq��>�)9����4�fW�`�!��c�T�?R�v��%��k=��{�z��#�z�x_I%i� RRӞ8���69�aڍ�|\i�V�����?�4l�֟non}�t���zU ��rS9�܂S=�^��a�]�͔ƹ�/_&~W�t�����Q/{����P�5dL�$7�{(�c|������g�!R0�J�é �{Y��Җ|]|5Fn�ܕ��KzsG#bE�v+�½���0[&�6[8��ε
��C�%��j4�+0��;��a�%6�bO椕[�Dٞ�dN�&�s�2�G�vc�T{��R�|v<T���Bn��#��E�1�ß��FE��F�N�uȅ�z^;
�3@X:�h�9��)1��h�jW(�ƹ=ީ�Ud3o�A��7���=n,LL1�,�\�*��mB�~�LT�e.y��
����kAL�� ٮ^?佾�5�)U��i����]a�+��!�<�{W�R �����4�W�:+���7.�J�c܄�z���ք��W�u�� BU���Mj	*�!Rd/�d�&K�8"����p��6���s�S�B6��]�I�i�W{����g�<@U���J4�������D�a��I�&�Z�D��!�.4���,     