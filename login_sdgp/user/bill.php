<?php
                if(isset($_POST['btn']))
                {
                    $units =$_POST['units'];
                    $total =0;
                    echo "<hr><h4>Bill Details</h4><hr>";
                    // 1st per unit 8.00Rs (0 - 30)
                    if($units>=0 && $units<=30)
                    {
                        $tot = $units * 8 + 150;
                        $tot1 = $tot * 18 / 100;
                        $total = $tot1 + $tot;
                        echo "<hr>Monthly Total Bill = $total<hr>";
                    }
                    // 2nd per unit 20.00Rs (31 - 60)
                    else if($units>30 && $units<=60)
                    {
                        $tot = 240 + ($units-30) * 20 + 300 ;
                        $tot1 = $tot * 18 / 100;
                        $total = $tot1 + $tot;
                        echo "<hr>Monthly Total Bill = $total<hr>";
                    }
                    // 3rd per unit 30.00Rs (61 - 90)
                    else if($units>60 && $units<=90)
                    {
                        $tot = 840 + ($units-60) * 30 + 400;
                        $tot1 = $tot * 18 / 100;
                        $total = $tot1 + $tot;
                        echo "<hr>Mothly Total Bill = $total<hr>";
                    }
                    // 4th per unit 50.00Rs (91 - 120)
                    else if($units>90 && $units<=120)
                    {
                        $tot = 1740 + ($units-90) * 50 + 1000;
                        $tot1 = $tot * 18 / 100;
                        $total = $tot1 + $tot;
                        echo "<hr>Monthly Total Bill = $total<hr>";
                    }
                    // 5th per unit 50.00Rs (121 - 180)
                    else if($units>120 && $units<=180)
                    {
                        $tot = 3240 + ($units-120) * 50 + 1500;
                        $tot1 = $tot * 18 / 100;
                        $total = $tot1 + $tot;
                        echo "<hr>Mothly Total Bill = $total<hr>";
                    }
                    // 6th per unit 75.00Rs (181 < )
                    else{
                        $tot = 6240 + ($units-180) * 75 + 2000;
                        $tot1 = $tot * 18 / 100;
                        $total = $tot1 + $tot;
                        echo "<hr>Monthly Total Bill = $total<hr>";
                    }
                }
            ?>