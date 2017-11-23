define <8 x float> @log256_ps(<8 x float> %x) #0 {
  %1 = tail call <8 x float> @llvm.x86.avx.cmp.ps.256(<8 x float> %x, <8 x float> zeroinitializer, i8 2)
  %2 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %x, <8 x float> <float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000>) #3
  %3 = bitcast <8 x float> %2 to <8 x i32>
  %4 = lshr <8 x i32> %3, <i32 23, i32 23, i32 23, i32 23, i32 23, i32 23, i32 23, i32 23>
  %5 = and <8 x i32> %3, <i32 -2139095041, i32 -2139095041, i32 -2139095041, i32 -2139095041, i32 -2139095041, i32 -2139095041, i32 -2139095041, i32 -2139095041>
  %6 = or <8 x i32> %5, <i32 1056964608, i32 1056964608, i32 1056964608, i32 1056964608, i32 1056964608, i32 1056964608, i32 1056964608, i32 1056964608>
  %7 = bitcast <8 x i32> %6 to <8 x float>
  %8 = add <8 x i32> %4, <i32 -127, i32 -127, i32 -127, i32 -127, i32 -127, i32 -127, i32 -127, i32 -127>
  %9 = tail call <8 x float> @llvm.x86.avx.cvtdq2.ps.256(<8 x i32> %8) #3
  %10 = fadd fast <8 x float> %9, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %11 = tail call <8 x float> @llvm.x86.avx.cmp.ps.256(<8 x float> %7, <8 x float> <float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000>, i8 1)
  %12 = bitcast <8 x float> %11 to <8 x i32>
  %13 = and <8 x i32> %6, %12
  %14 = bitcast <8 x i32> %13 to <8 x float>
  %15 = fadd fast <8 x float> %7, <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>
  %16 = and <8 x i32> %12, <i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216>
  %17 = bitcast <8 x i32> %16 to <8 x float>
  %18 = fsub fast <8 x float> %10, %17
  %19 = fadd fast <8 x float> %15, %14
  %20 = fmul fast <8 x float> %19, %19
  %21 = fmul fast <8 x float> %19, <float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000>
  %22 = fadd fast <8 x float> %21, <float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000>
  %23 = fmul fast <8 x float> %19, %22
  %24 = fadd fast <8 x float> %23, <float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000>
  %25 = fmul fast <8 x float> %19, %24
  %26 = fadd fast <8 x float> %25, <float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000>
  %27 = fmul fast <8 x float> %19, %26
  %28 = fadd fast <8 x float> %27, <float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000>
  %29 = fmul fast <8 x float> %19, %28
  %30 = fadd fast <8 x float> %29, <float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000>
  %31 = fmul fast <8 x float> %19, %30
  %32 = fadd fast <8 x float> %31, <float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000>
  %33 = fmul fast <8 x float> %19, %32
  %34 = fadd fast <8 x float> %33, <float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000>
  %35 = fmul fast <8 x float> %19, %34
  %36 = fadd fast <8 x float> %35, <float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000>
  %37 = fmul fast <8 x float> %19, %36
  %38 = fmul fast <8 x float> %20, %37
  %39 = fmul fast <8 x float> %18, <float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000>
  %40 = fadd fast <8 x float> %39, %38
  %41 = fmul fast <8 x float> %20, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %42 = fsub fast <8 x float> %40, %41
  %43 = fmul fast <8 x float> %18, <float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000>
  %44 = fadd fast <8 x float> %19, %42
  %45 = fadd fast <8 x float> %43, %44
  %46 = bitcast <8 x float> %45 to <8 x i32>
  %47 = bitcast <8 x float> %1 to <8 x i32>
  %48 = or <8 x i32> %46, %47
  %49 = bitcast <8 x i32> %48 to <8 x float>
  ret <8 x float> %49
}

declare <8 x float> @llvm.x86.avx.cmp.ps.256(<8 x float>, <8 x float>, i8) 

define <8 x float> @exp256_ps(<8 x float> %x) #0 {
  %1 = tail call <8 x float> @llvm.x86.avx.min.ps.256(<8 x float> %x, <8 x float> <float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000>) #3
  %2 = tail call <8 x float> @llvm.x86.avx.max.ps.256(<8 x float> %1, <8 x float> <float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000>) #3
  %3 = fmul fast <8 x float> %2, <float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000>
  %4 = fadd fast <8 x float> %3, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %5 = tail call <8 x float> @llvm.x86.avx.round.ps.256(<8 x float> %4, i32 1)
  %6 = tail call <8 x float> @llvm.x86.avx.cmp.ps.256(<8 x float> %5, <8 x float> %4, i8 14)
  %7 = bitcast <8 x float> %6 to <8 x i32>
  %8 = and <8 x i32> %7, <i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216>
  %9 = bitcast <8 x i32> %8 to <8 x float>
  %10 = fsub fast <8 x float> %5, %9
  %11 = fmul fast <8 x float> %10, <float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000>
  %12 = fmul fast <8 x float> %10, <float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000>
  %13 = fsub fast <8 x float> %2, %11
  %14 = fsub fast <8 x float> %13, %12
  %15 = fmul fast <8 x float> %14, %14
  %16 = fmul fast <8 x float> %14, <float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000>
  %17 = fadd fast <8 x float> %16, <float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000>
  %18 = fmul fast <8 x float> %14, %17
  %19 = fadd fast <8 x float> %18, <float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000>
  %20 = fmul fast <8 x float> %14, %19
  %21 = fadd fast <8 x float> %20, <float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000>
  %22 = fmul fast <8 x float> %14, %21
  %23 = fadd fast <8 x float> %22, <float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000>
  %24 = fmul fast <8 x float> %14, %23
  %25 = fadd fast <8 x float> %24, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %26 = fmul fast <8 x float> %15, %25
  %27 = fadd fast <8 x float> %14, %26
  %28 = fadd fast <8 x float> %27, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %29 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %10) #3
  %30 = add <8 x i32> %29, <i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127, i32 127>
  %31 = shl <8 x i32> %30, <i32 23, i32 23, i32 23, i32 23, i32 23, i32 23, i32 23, i32 23>
  %32 = bitcast <8 x i32> %31 to <8 x float>
  %33 = fmul fast <8 x float> %32, %28
  ret <8 x float> %33
}

declare <8 x float> @llvm.x86.avx.round.ps.256(<8 x float>, i32) 

define <8 x float> @sin256_ps(<8 x float> %x) #0 {
  %1 = bitcast <8 x float> %x to <8 x i32>
  %2 = and <8 x i32> %1, <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
  %3 = bitcast <8 x i32> %2 to <8 x float>
  %4 = and <8 x i32> %1, <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648>
  %5 = fmul fast <8 x float> %3, <float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000>
  %6 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %5) #3
  %7 = add <8 x i32> %6, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %8 = bitcast <8 x i32> %7 to <4 x i64>
  %9 = and <4 x i64> %8, <i64 -4294967298, i64 -4294967298, i64 -4294967298, i64 -4294967298>
  %10 = bitcast <4 x i64> %9 to <8 x i32>
  %11 = tail call <8 x float> @llvm.x86.avx.cvtdq2.ps.256(<8 x i32> %10) #3
  %12 = and <4 x i64> %8, <i64 17179869188, i64 17179869188, i64 17179869188, i64 17179869188>
  %13 = bitcast <4 x i64> %12 to <8 x i32>
  %14 = shl <8 x i32> %13, <i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29>
  %15 = and <4 x i64> %8, <i64 8589934594, i64 8589934594, i64 8589934594, i64 8589934594>
  %16 = bitcast <4 x i64> %15 to <8 x i32>
  %17 = icmp eq <8 x i32> %16, zeroinitializer
  %18 = xor <8 x i32> %4, %14
  %19 = fmul fast <8 x float> %11, <float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000>
  %20 = fmul fast <8 x float> %11, <float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000>
  %21 = fmul fast <8 x float> %11, <float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000>
  %22 = fadd fast <8 x float> %3, %19
  %23 = fadd fast <8 x float> %20, %22
  %24 = fadd fast <8 x float> %21, %23
  %25 = fmul fast <8 x float> %24, %24
  %26 = fmul fast <8 x float> %25, <float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000>
  %27 = fadd fast <8 x float> %26, <float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000>
  %28 = fmul fast <8 x float> %25, %27
  %29 = fadd fast <8 x float> %28, <float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000>
  %30 = fmul fast <8 x float> %25, %25
  %31 = fmul fast <8 x float> %30, %29
  %32 = fmul fast <8 x float> %25, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %33 = fsub fast <8 x float> %31, %32
  %34 = fadd fast <8 x float> %33, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %35 = fmul fast <8 x float> %25, <float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000>
  %36 = fadd fast <8 x float> %35, <float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000>
  %37 = fmul fast <8 x float> %25, %36
  %38 = fadd fast <8 x float> %37, <float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000>
  %39 = fmul fast <8 x float> %25, %38
  %40 = fmul fast <8 x float> %24, %39
  %41 = fadd fast <8 x float> %24, %40
  %42 = select <8 x i1> %17, <8 x float> %41, <8 x float> %34
  %43 = bitcast <8 x float> %42 to <8 x i32>
  %44 = xor <8 x i32> %43, %18
  %45 = bitcast <8 x i32> %44 to <8 x float>
  ret <8 x float> %45
}

define <8 x float> @cos256_ps(<8 x float> %x) #0 {
  %1 = bitcast <8 x float> %x to <8 x i32>
  %2 = and <8 x i32> %1, <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
  %3 = bitcast <8 x i32> %2 to <8 x float>
  %4 = fmul fast <8 x float> %3, <float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000>
  %5 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %4) #3
  %6 = add <8 x i32> %5, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %7 = bitcast <8 x i32> %6 to <4 x i64>
  %8 = and <4 x i64> %7, <i64 -4294967298, i64 -4294967298, i64 -4294967298, i64 -4294967298>
  %9 = bitcast <4 x i64> %8 to <8 x i32>
  %10 = tail call <8 x float> @llvm.x86.avx.cvtdq2.ps.256(<8 x i32> %9) #3
  %11 = add <8 x i32> %9, <i32 -2, i32 -2, i32 -2, i32 -2, i32 -2, i32 -2, i32 -2, i32 -2>
  %12 = bitcast <8 x i32> %11 to <4 x i64>
  %13 = xor <4 x i64> %12, <i64 -1, i64 -1, i64 -1, i64 -1>
  %14 = and <4 x i64> %13, <i64 17179869188, i64 17179869188, i64 17179869188, i64 17179869188>
  %15 = bitcast <4 x i64> %14 to <8 x i32>
  %16 = shl <8 x i32> %15, <i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29>
  %17 = and <4 x i64> %12, <i64 8589934594, i64 8589934594, i64 8589934594, i64 8589934594>
  %18 = bitcast <4 x i64> %17 to <8 x i32>
  %19 = icmp eq <8 x i32> %18, zeroinitializer
  %20 = fmul fast <8 x float> %10, <float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000>
  %21 = fmul fast <8 x float> %10, <float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000>
  %22 = fmul fast <8 x float> %10, <float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000>
  %23 = fadd fast <8 x float> %3, %20
  %24 = fadd fast <8 x float> %21, %23
  %25 = fadd fast <8 x float> %22, %24
  %26 = fmul fast <8 x float> %25, %25
  %27 = fmul fast <8 x float> %26, <float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000>
  %28 = fadd fast <8 x float> %27, <float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000>
  %29 = fmul fast <8 x float> %26, %28
  %30 = fadd fast <8 x float> %29, <float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000>
  %31 = fmul fast <8 x float> %26, %26
  %32 = fmul fast <8 x float> %31, %30
  %33 = fmul fast <8 x float> %26, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %34 = fsub fast <8 x float> %32, %33
  %35 = fadd fast <8 x float> %34, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %36 = fmul fast <8 x float> %26, <float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000>
  %37 = fadd fast <8 x float> %36, <float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000>
  %38 = fmul fast <8 x float> %26, %37
  %39 = fadd fast <8 x float> %38, <float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000>
  %40 = fmul fast <8 x float> %26, %39
  %41 = fmul fast <8 x float> %25, %40
  %42 = fadd fast <8 x float> %25, %41
  %43 = select <8 x i1> %19, <8 x float> %42, <8 x float> %35
  %44 = bitcast <8 x float> %43 to <8 x i32>
  %45 = xor <8 x i32> %44, %16
  %46 = bitcast <8 x i32> %45 to <8 x float>
  ret <8 x float> %46
}

define void @sincos256_ps(<8 x float> %x, <8 x float>* nocapture %s, <8 x float>* nocapture %c) #0 {
  %1 = bitcast <8 x float> %x to <8 x i32>
  %2 = and <8 x i32> %1, <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
  %3 = bitcast <8 x i32> %2 to <8 x float>
  %4 = and <8 x i32> %1, <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648>
  %5 = fmul fast <8 x float> %3, <float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000>
  %6 = tail call <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float> %5) #3
  %7 = add <8 x i32> %6, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %8 = bitcast <8 x i32> %7 to <4 x i64>
  %9 = and <4 x i64> %8, <i64 -4294967298, i64 -4294967298, i64 -4294967298, i64 -4294967298>
  %10 = bitcast <4 x i64> %9 to <8 x i32>
  %11 = tail call <8 x float> @llvm.x86.avx.cvtdq2.ps.256(<8 x i32> %10) #3
  %12 = and <4 x i64> %8, <i64 17179869188, i64 17179869188, i64 17179869188, i64 17179869188>
  %13 = bitcast <4 x i64> %12 to <8 x i32>
  %14 = shl <8 x i32> %13, <i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29>
  %15 = and <4 x i64> %8, <i64 8589934594, i64 8589934594, i64 8589934594, i64 8589934594>
  %16 = bitcast <4 x i64> %15 to <8 x i32>
  %17 = icmp eq <8 x i32> %16, zeroinitializer
  %18 = fmul fast <8 x float> %11, <float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000>
  %19 = fmul fast <8 x float> %11, <float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000>
  %20 = fmul fast <8 x float> %11, <float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000>
  %21 = fadd fast <8 x float> %3, %18
  %22 = fadd fast <8 x float> %19, %21
  %23 = fadd fast <8 x float> %20, %22
  %24 = add <8 x i32> %10, <i32 -2, i32 -2, i32 -2, i32 -2, i32 -2, i32 -2, i32 -2, i32 -2>
  %25 = bitcast <8 x i32> %24 to <4 x i64>
  %26 = xor <4 x i64> %25, <i64 -1, i64 -1, i64 -1, i64 -1>
  %27 = and <4 x i64> %26, <i64 17179869188, i64 17179869188, i64 17179869188, i64 17179869188>
  %28 = bitcast <4 x i64> %27 to <8 x i32>
  %29 = shl <8 x i32> %28, <i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29, i32 29>
  %30 = xor <8 x i32> %4, %14
  %31 = fmul fast <8 x float> %23, %23
  %32 = fmul fast <8 x float> %31, <float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000>
  %33 = fadd fast <8 x float> %32, <float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000>
  %34 = fmul fast <8 x float> %31, %33
  %35 = fadd fast <8 x float> %34, <float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000>
  %36 = fmul fast <8 x float> %31, %31
  %37 = fmul fast <8 x float> %36, %35
  %38 = fmul fast <8 x float> %31, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %39 = fsub fast <8 x float> %37, %38
  %40 = fadd fast <8 x float> %39, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %41 = fmul fast <8 x float> %31, <float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000>
  %42 = fadd fast <8 x float> %41, <float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000>
  %43 = fmul fast <8 x float> %31, %42
  %44 = fadd fast <8 x float> %43, <float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000>
  %45 = fmul fast <8 x float> %31, %44
  %46 = fmul fast <8 x float> %23, %45
  %47 = fadd fast <8 x float> %23, %46
  %48 = select <8 x i1> %17, <8 x float> %47, <8 x float> zeroinitializer
  %49 = select <8 x i1> %17, <8 x float> zeroinitializer, <8 x float> %40
  %50 = fsub fast <8 x float> %47, %48
  %51 = fsub fast <8 x float> %40, %49
  %52 = select <8 x i1> %17, <8 x float> %47, <8 x float> %40
  %53 = fadd fast <8 x float> %51, %50
  %54 = bitcast <8 x float> %52 to <8 x i32>
  %55 = xor <8 x i32> %54, %30
  %56 = bitcast <8 x i32> %55 to <8 x float>
  store <8 x float> %56, <8 x float>* %s, align 32
  %57 = bitcast <8 x float> %53 to <8 x i32>
  %58 = xor <8 x i32> %57, %29
  %59 = bitcast <8 x i32> %58 to <8 x float>
  store <8 x float> %59, <8 x float>* %c, align 32
  ret void
}

declare <8 x i32> @llvm.x86.avx.cvtt.ps2dq.256(<8 x float>) 
declare <8 x float> @llvm.x86.avx.min.ps.256(<8 x float>, <8 x float>) 
declare <8 x float> @llvm.x86.avx.cvtdq2.ps.256(<8 x i32>) 
declare <8 x float> @llvm.x86.avx.max.ps.256(<8 x float>, <8 x float>) 


attributes #0 = { noinline nounwind ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+adx,+aes,+avx,+avx2,+mmx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }
