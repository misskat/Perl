#In PHASE format the alleles of the genotype
#are split between 2 lines

#!usr/bin/perl

$numArgs = $#ARGV + 1;
my $filename_ped = $ARGV[0];
my $filename_out = $ARGV[1];

open (PED, $filename_ped) || die "cannot open $filename_ped.\n";
open (OUT, "> ".$filename_out) || die "cannot open $filename_out.\n";

# rs7678151, 4983730 has a Mendel error, so is removed here
print OUT "N\n538\nP 1001110 1009010 1014750 1042490 1068190 1077530 1081930 1085280 1091220 1095680 1103260 1114040 1114680 1149680 1152020 1155130 1155520 1169210 1181040 1183830 1193270 1203700 1214810 1217470 1227010 1235280 1275520 1281340 1328620 1342680 1355860 1376570 1377780 1404680 1405700 1470080 1476530 1488620 1493470 1498510 1504780 1510200 1512030 1515500 1521540 1524880 1533980 1536220 1543450 1556000 1561340 1565920 1568290 1580830 1589490 1594670 1601790 1617560 1628920 1640650 1649220 1674340 1682210 1690350 1691450 1694380 1697920 1704040 1740150 1754820 1767650 1836160 1871710 1927970 1930400 1956740 1967890 2021320 2048650 2063830 2072100 2072890 2076030 2107840 2115520 2122250 2134740 2146250 2150880 2151410 2155710 2164740 2164820 2179860 2181790 2203510 2214660 2220540 2248210 2264380 2270640 2272900 2273370 2274570 2281160 2286670 2289140 2294660 2295710 2299090 2306620 2310210 2313650 2314490 2321150 2324150 2329600 2346220 2355180 2366880 2371140 2372500 2392070 2398710 2405840 2406050 2407090 2416330 2417770 2421890 2427880 2441600 2456280 2457160 2464040 2474890 2481850 2650310 2657320 2659250 2670900 2672900 2680440 2689870 2693330 2714280 2725250 2730020 2740570 2764120 2774270 2785430 2786100 2801180 2806430 2819940 2851050 2858240 2876080 2904110 2918250 2921600 2927980 2941300 2958430 2960300 2975840 2994520 2999390 3014230 3017340 3023810 3028380 3033620 3038340 3049970 3059060 3081210 3117070 3118810 3130430 3147060 3149820 3156790 3165830 3185630 3201460 3204780 3205320 3212110 3222650 3233570 3237470 3245280 3254360 3273770 3275540 3308840 3311940 3314690 3320050 3339440 3346100 3356110 3366760 3383010 3389480 3392010 3399650 3404130 3414300 3420910 3431700 3442940 3455580 3460130 3464400 3466740 3474360 3475250 3482920 3494850 3505800 3543060 3554170 3571910 3614760 3628540 3629370 3630930 3631010 3634000 3640480 3653070 3657160 3673520 3676580 3681880 3683980 3689180 3689630 3704690 3712800 3717640 3719950 3735550 3749870 3762010 3974650 4031030 4133840 4234830 4241840 4256250 4258270 4259760 4270490 4297960 4303860 4308730 4309790 4314480 4321630 4328640 4343720 4355420 4360580 4378810 4386730 4390930 4394140 4394160 4397140 4398410 4403990 4406280 4406670 4411280 4411560 4415970 4420120 4423340 4427070 4428070 4432330 4438460 4443970 4447440 4448440 4453250 4481040 4496220 4497370 4511830 4517000 4538280 4550940 4551030 4553660 4560650 4567240 4574100 4575730 4601530 4608160 4610130 4614760 4620360 4624230 4629940 4637340 4644790 4648320 4653810 4670050 4690450 4698950 4699820 4705260 4714930 4717230 4729410 4743630 4761100 4770390 4775580 4778410 4794940 4796630 4805390 4814750 4818600 4845720 4850590 4853850 4863760 4869830 4877780 4887960 4900300 4911300 4916050 4939890 4942050 4946800 4958060 4958920 4962540 4963840 4963890 4968410 4974200 4977070 4986110 4986210 4993050 4997010 5001110 5013830 5025570 5035090 5041660 5046780 5056600 5058280 5066070 5066390 5067780 5073400 5074010 5090130 5094570 5098600 5106680 5111330 5112270 5118690 5122590 5124930 5128060 5129690 5132900 5137120 5138450 5152030 5161040 5163880 5172350 5176620 5189500 5203900 5204050 5205570 5206250 5211170 5222890 5233000 5233840 5237780 5238300 5238440 5243430 5243630 5247450 5253700 5258470 5261470 5263190 5264330 5266180 5267220 5270240 5272480 5280780 5283450 5288090 5292470 5316220 5339060 5344200 5367350 5378120 5383460 5428390 5434120 5435550 5441540 5442540 5445970 5446870 5455400 5465030 5476260 5482220 5485760 5487490 5499330 5503640 5503800 5511960 5513910 5516470 5520120 5531240 5566930 5569020 5583890 5598240 5614100 5631680 5642350 5659320 5659950 5663510 5675570 5680200 5684900 5689550 5691250 5697920 5709460 5716100 5720820 5722380 5726690 5733090 5733710 5734560 5737820 5738530 5741800 5747280 5749720 5754530 5756030 5762270 5769480 5771920 5772670 5774050 5786200 5786720 5787390 5789080 5793950 5794410 5796620 5797520 5803950 5806440 5809770 5810250 5813060 5822350 5828750 5830220 5836340 5845810 5849530 5854800 5855730 5859920 5860090 5863470 5866830 5871060 5880160 5884530 5887600 5891790 5894170 5898390 5902240 5903040 5907810 5908750 5916260 5917850 5919880 5922390 5924550 5927920 5933750 5936520 5940150 5947600 5953170 5962880 5970610 5971240 5975190 5977450 5979090 5982110 5987470 5990100 5993870 5996010\nSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS\n";

#plink file
while (<PED>) {

    chomp;

#    ($FID, $IID, $PID, $MID, $sex, $pheno, $geno) = split(" ");
    
    my @items = split(" ");

    my $len = @items;

    print OUT "#"."$items[1]\n";

#even
    for (my $i = 6; $i < $len; $i+=2) {
	print OUT $items[$i];
    }
    print OUT "\n";

#odd 
    for (my $i = 7; $i < $len; $i+=2) {
	print OUT $items[$i];
    }
    print OUT "\n";
}

close(PED);
close(OUT);