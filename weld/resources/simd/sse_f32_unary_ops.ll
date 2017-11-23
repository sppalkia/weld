; Function Attrs: nounwind ssp uwtable
define <4 x float> @log_ps(<4 x float> %x) #0 {
  %1 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> %x, <4 x float> zeroinitializer, i8 2) #2
  %2 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> %x, <4 x float> <float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000, float 0x3810000000000000>) #2
  %3 = shufflevector <4 x float> %2, <4 x float> undef, <2 x i32> <i32 0, i32 1>
  %4 = bitcast <2 x float> %3 to <1 x i64>
  %5 = shufflevector <4 x float> %2, <4 x float> undef, <2 x i32> <i32 2, i32 3>
  %6 = bitcast <2 x float> %5 to <1 x i64>
  %7 = extractelement <1 x i64> %4, i32 0
  %8 = bitcast i64 %7 to <2 x i32>
  %9 = bitcast <2 x i32> %8 to x86_mmx
  %10 = tail call x86_mmx @llvm.x86.mmx.psrli.d(x86_mmx %9, i32 23) #2
  %11 = bitcast x86_mmx %10 to <2 x i32>
  %12 = bitcast <2 x i32> %11 to <1 x i64>
  %13 = extractelement <1 x i64> %12, i32 0
  %14 = extractelement <1 x i64> %6, i32 0
  %15 = bitcast i64 %14 to <2 x i32>
  %16 = bitcast <2 x i32> %15 to x86_mmx
  %17 = tail call x86_mmx @llvm.x86.mmx.psrli.d(x86_mmx %16, i32 23) #2
  %18 = bitcast x86_mmx %17 to <2 x i32>
  %19 = bitcast <2 x i32> %18 to <1 x i64>
  %20 = extractelement <1 x i64> %19, i32 0
  %21 = bitcast <4 x float> %2 to <4 x i32>
  %22 = and <4 x i32> %21, <i32 -2139095041, i32 -2139095041, i32 -2139095041, i32 -2139095041>
  %23 = or <4 x i32> %22, <i32 1056964608, i32 1056964608, i32 1056964608, i32 1056964608>
  %24 = bitcast <4 x i32> %23 to <4 x float>
  %25 = bitcast i64 %13 to <2 x i32>
  %26 = bitcast <2 x i32> %25 to x86_mmx
  %27 = tail call x86_mmx @llvm.x86.mmx.psub.d(x86_mmx %26, x86_mmx bitcast (<2 x i32> <i32 127, i32 127> to x86_mmx)) #2
  %28 = bitcast x86_mmx %27 to <2 x i32>
  %29 = bitcast <2 x i32> %28 to <1 x i64>
  %30 = extractelement <1 x i64> %29, i32 0
  %31 = bitcast i64 %20 to <2 x i32>
  %32 = bitcast <2 x i32> %31 to x86_mmx
  %33 = tail call x86_mmx @llvm.x86.mmx.psub.d(x86_mmx %32, x86_mmx bitcast (<2 x i32> <i32 127, i32 127> to x86_mmx)) #2
  %34 = bitcast x86_mmx %33 to <2 x i32>
  %35 = bitcast <2 x i32> %34 to <1 x i64>
  %36 = extractelement <1 x i64> %35, i32 0
  %37 = bitcast i64 %36 to <2 x i32>
  %38 = bitcast <2 x i32> %37 to x86_mmx
  %39 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> zeroinitializer, x86_mmx %38) #2
  %40 = shufflevector <4 x float> %39, <4 x float> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %41 = bitcast i64 %30 to <2 x i32>
  %42 = bitcast <2 x i32> %41 to x86_mmx
  %43 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> %40, x86_mmx %42) #2
  tail call void @llvm.x86.mmx.emms() #2
  %44 = fadd fast <4 x float> %43, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %45 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> %24, <4 x float> <float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000, float 0x3FE6A09E60000000>, i8 1) #2
  %46 = bitcast <4 x float> %45 to <4 x i32>
  %47 = and <4 x i32> %23, %46
  %48 = bitcast <4 x i32> %47 to <4 x float>
  %49 = fadd fast <4 x float> %24, <float -1.000000e+00, float -1.000000e+00, float -1.000000e+00, float -1.000000e+00>
  %50 = and <4 x i32> %46, <i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216>
  %51 = bitcast <4 x i32> %50 to <4 x float>
  %52 = fsub fast <4 x float> %44, %51
  %53 = fadd fast <4 x float> %49, %48
  %54 = fmul fast <4 x float> %53, %53
  %55 = fmul fast <4 x float> %53, <float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000, float 0x3FB2043760000000>
  %56 = fadd fast <4 x float> %55, <float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000, float 0xBFBD7A3700000000>
  %57 = fmul fast <4 x float> %53, %56
  %58 = fadd fast <4 x float> %57, <float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000, float 0x3FBDE4A340000000>
  %59 = fmul fast <4 x float> %53, %58
  %60 = fadd fast <4 x float> %59, <float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000, float 0xBFBFCBA9E0000000>
  %61 = fmul fast <4 x float> %53, %60
  %62 = fadd fast <4 x float> %61, <float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000, float 0x3FC23D37E0000000>
  %63 = fmul fast <4 x float> %53, %62
  %64 = fadd fast <4 x float> %63, <float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000, float 0xBFC555CA00000000>
  %65 = fmul fast <4 x float> %53, %64
  %66 = fadd fast <4 x float> %65, <float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000, float 0x3FC999D580000000>
  %67 = fmul fast <4 x float> %53, %66
  %68 = fadd fast <4 x float> %67, <float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000, float 0xBFCFFFFF80000000>
  %69 = fmul fast <4 x float> %53, %68
  %70 = fadd fast <4 x float> %69, <float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000, float 0x3FD5555540000000>
  %71 = fmul fast <4 x float> %53, %70
  %72 = fmul fast <4 x float> %54, %71
  %73 = fmul fast <4 x float> %52, <float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000>
  %74 = fadd fast <4 x float> %73, %72
  %75 = fmul fast <4 x float> %54, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %76 = fsub fast <4 x float> %74, %75
  %77 = fmul fast <4 x float> %52, <float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000>
  %78 = fadd fast <4 x float> %53, %76
  %79 = fadd fast <4 x float> %77, %78
  %80 = bitcast <4 x float> %79 to <4 x i32>
  %81 = bitcast <4 x float> %1 to <4 x i32>
  %82 = or <4 x i32> %80, %81
  %83 = bitcast <4 x i32> %82 to <4 x float>
  ret <4 x float> %83
}

; Function Attrs: nounwind ssp uwtable
define <4 x float> @exp_ps(<4 x float> %x) #0 {
  %1 = tail call <4 x float> @llvm.x86.sse.min.ps(<4 x float> %x, <4 x float> <float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000, float 0x40561814A0000000>) #2
  %2 = tail call <4 x float> @llvm.x86.sse.max.ps(<4 x float> %1, <4 x float> <float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000, float 0xC0561814A0000000>) #2
  %3 = fmul fast <4 x float> %2, <float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000, float 0x3FF7154760000000>
  %4 = fadd fast <4 x float> %3, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %5 = shufflevector <4 x float> <float undef, float undef, float 0.000000e+00, float 0.000000e+00>, <4 x float> %4, <4 x i32> <i32 6, i32 7, i32 2, i32 3>
  %6 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %4) #2
  %7 = bitcast x86_mmx %6 to <2 x i32>
  %8 = bitcast <2 x i32> %7 to <1 x i64>
  %9 = extractelement <1 x i64> %8, i32 0
  %10 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %5) #2
  %11 = bitcast x86_mmx %10 to <2 x i32>
  %12 = bitcast <2 x i32> %11 to <1 x i64>
  %13 = extractelement <1 x i64> %12, i32 0
  %14 = bitcast i64 %13 to <2 x i32>
  %15 = bitcast <2 x i32> %14 to x86_mmx
  %16 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> zeroinitializer, x86_mmx %15) #2
  %17 = shufflevector <4 x float> %16, <4 x float> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %18 = bitcast i64 %9 to <2 x i32>
  %19 = bitcast <2 x i32> %18 to x86_mmx
  %20 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> %17, x86_mmx %19) #2
  %21 = tail call <4 x float> @llvm.x86.sse.cmp.ps(<4 x float> %4, <4 x float> %20, i8 1) #2
  %22 = bitcast <4 x float> %21 to <4 x i32>
  %23 = and <4 x i32> %22, <i32 1065353216, i32 1065353216, i32 1065353216, i32 1065353216>
  %24 = bitcast <4 x i32> %23 to <4 x float>
  %25 = fsub fast <4 x float> %20, %24
  %26 = fmul fast <4 x float> %25, <float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000, float 0x3FE6300000000000>
  %27 = fmul fast <4 x float> %25, <float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000, float 0xBF2BD01060000000>
  %28 = fsub fast <4 x float> %2, %26
  %29 = fsub fast <4 x float> %28, %27
  %30 = fmul fast <4 x float> %29, %29
  %31 = fmul fast <4 x float> %29, <float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000, float 0x3F2A0D2CE0000000>
  %32 = fadd fast <4 x float> %31, <float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000, float 0x3F56E879C0000000>
  %33 = fmul fast <4 x float> %29, %32
  %34 = fadd fast <4 x float> %33, <float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000, float 0x3F81112100000000>
  %35 = fmul fast <4 x float> %29, %34
  %36 = fadd fast <4 x float> %35, <float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000, float 0x3FA5553820000000>
  %37 = fmul fast <4 x float> %29, %36
  %38 = fadd fast <4 x float> %37, <float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000, float 0x3FC5555540000000>
  %39 = fmul fast <4 x float> %29, %38
  %40 = fadd fast <4 x float> %39, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %41 = fmul fast <4 x float> %30, %40
  %42 = fadd fast <4 x float> %29, %41
  %43 = fadd fast <4 x float> %42, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %44 = shufflevector <4 x float> %30, <4 x float> %25, <4 x i32> <i32 6, i32 7, i32 2, i32 3>
  %45 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %25) #2
  %46 = bitcast x86_mmx %45 to <2 x i32>
  %47 = bitcast <2 x i32> %46 to <1 x i64>
  %48 = extractelement <1 x i64> %47, i32 0
  %49 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %44) #2
  %50 = bitcast x86_mmx %49 to <2 x i32>
  %51 = bitcast <2 x i32> %50 to <1 x i64>
  %52 = extractelement <1 x i64> %51, i32 0
  %53 = bitcast i64 %48 to <2 x i32>
  %54 = bitcast <2 x i32> %53 to x86_mmx
  %55 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %54, x86_mmx bitcast (<2 x i32> <i32 127, i32 127> to x86_mmx)) #2
  %56 = bitcast x86_mmx %55 to <2 x i32>
  %57 = bitcast <2 x i32> %56 to <1 x i64>
  %58 = extractelement <1 x i64> %57, i32 0
  %59 = bitcast i64 %52 to <2 x i32>
  %60 = bitcast <2 x i32> %59 to x86_mmx
  %61 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %60, x86_mmx bitcast (<2 x i32> <i32 127, i32 127> to x86_mmx)) #2
  %62 = bitcast x86_mmx %61 to <2 x i32>
  %63 = bitcast <2 x i32> %62 to <1 x i64>
  %64 = extractelement <1 x i64> %63, i32 0
  %65 = bitcast i64 %58 to <2 x i32>
  %66 = bitcast <2 x i32> %65 to x86_mmx
  %67 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %66, i32 23) #2
  %68 = bitcast x86_mmx %67 to <2 x i32>
  %69 = bitcast <2 x i32> %68 to <1 x i64>
  %70 = extractelement <1 x i64> %69, i32 0
  %71 = bitcast i64 %64 to <2 x i32>
  %72 = bitcast <2 x i32> %71 to x86_mmx
  %73 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %72, i32 23) #2
  %74 = bitcast x86_mmx %73 to <2 x i32>
  %75 = bitcast <2 x i32> %74 to <1 x i64>
  %76 = extractelement <1 x i64> %75, i32 0
  %77 = bitcast i64 %70 to <2 x float>
  %78 = shufflevector <2 x float> %77, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %79 = bitcast i64 %76 to <2 x float>
  %80 = shufflevector <2 x float> %79, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %81 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %80, <4 x float> %78
  tail call void @llvm.x86.mmx.emms() #2
  %82 = fmul fast <4 x float> %81, %43
  ret <4 x float> %82
}

; Function Attrs: nounwind ssp uwtable
define <4 x float> @sin_ps(<4 x float> %x) #0 {
  %1 = bitcast <4 x float> %x to <4 x i32>
  %2 = and <4 x i32> %1, <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
  %3 = bitcast <4 x i32> %2 to <4 x float>
  %4 = and <4 x i32> %1, <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648>
  %5 = fmul fast <4 x float> %3, <float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000>
  %6 = shufflevector <4 x float> <float undef, float undef, float 0.000000e+00, float 0.000000e+00>, <4 x float> %5, <4 x i32> <i32 6, i32 7, i32 2, i32 3>
  %7 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %5) #2
  %8 = bitcast x86_mmx %7 to <2 x i32>
  %9 = bitcast <2 x i32> %8 to <1 x i64>
  %10 = extractelement <1 x i64> %9, i32 0
  %11 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %6) #2
  %12 = bitcast x86_mmx %11 to <2 x i32>
  %13 = bitcast <2 x i32> %12 to <1 x i64>
  %14 = extractelement <1 x i64> %13, i32 0
  %15 = bitcast i64 %10 to <2 x i32>
  %16 = bitcast <2 x i32> %15 to x86_mmx
  %17 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %16, x86_mmx bitcast (<2 x i32> <i32 1, i32 1> to x86_mmx)) #2
  %18 = bitcast x86_mmx %17 to <2 x i32>
  %19 = bitcast <2 x i32> %18 to <1 x i64>
  %20 = extractelement <1 x i64> %19, i32 0
  %21 = bitcast i64 %14 to <2 x i32>
  %22 = bitcast <2 x i32> %21 to x86_mmx
  %23 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %22, x86_mmx bitcast (<2 x i32> <i32 1, i32 1> to x86_mmx)) #2
  %24 = bitcast x86_mmx %23 to <2 x i32>
  %25 = bitcast <2 x i32> %24 to <1 x i64>
  %26 = extractelement <1 x i64> %25, i32 0
  %27 = bitcast i64 %20 to x86_mmx
  %28 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %27, x86_mmx bitcast (i64 -4294967298 to x86_mmx)) #2
  %29 = bitcast x86_mmx %28 to i64
  %30 = bitcast i64 %26 to x86_mmx
  %31 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %30, x86_mmx bitcast (i64 -4294967298 to x86_mmx)) #2
  %32 = bitcast x86_mmx %31 to i64
  %33 = bitcast i64 %32 to <2 x i32>
  %34 = bitcast <2 x i32> %33 to x86_mmx
  %35 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> zeroinitializer, x86_mmx %34) #2
  %36 = shufflevector <4 x float> %35, <4 x float> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %37 = bitcast i64 %29 to <2 x i32>
  %38 = bitcast <2 x i32> %37 to x86_mmx
  %39 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> %36, x86_mmx %38) #2
  %40 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %28, x86_mmx bitcast (i64 17179869188 to x86_mmx)) #2
  %41 = bitcast x86_mmx %40 to i64
  %42 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %31, x86_mmx bitcast (i64 17179869188 to x86_mmx)) #2
  %43 = bitcast x86_mmx %42 to i64
  %44 = bitcast i64 %41 to <2 x i32>
  %45 = bitcast <2 x i32> %44 to x86_mmx
  %46 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %45, i32 29) #2
  %47 = bitcast x86_mmx %46 to <2 x i32>
  %48 = bitcast <2 x i32> %47 to <1 x i64>
  %49 = extractelement <1 x i64> %48, i32 0
  %50 = bitcast i64 %43 to <2 x i32>
  %51 = bitcast <2 x i32> %50 to x86_mmx
  %52 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %51, i32 29) #2
  %53 = bitcast x86_mmx %52 to <2 x i32>
  %54 = bitcast <2 x i32> %53 to <1 x i64>
  %55 = extractelement <1 x i64> %54, i32 0
  %56 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %28, x86_mmx bitcast (i64 8589934594 to x86_mmx)) #2
  %57 = bitcast x86_mmx %56 to i64
  %58 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %31, x86_mmx bitcast (i64 8589934594 to x86_mmx)) #2
  %59 = bitcast x86_mmx %58 to i64
  %60 = bitcast i64 %57 to <2 x i32>
  %61 = bitcast <2 x i32> %60 to x86_mmx
  %62 = tail call x86_mmx @llvm.x86.mmx.pcmpeq.d(x86_mmx %61, x86_mmx bitcast (<2 x i32> zeroinitializer to x86_mmx)) #2
  %63 = bitcast x86_mmx %62 to <2 x i32>
  %64 = bitcast <2 x i32> %63 to <1 x i64>
  %65 = extractelement <1 x i64> %64, i32 0
  %66 = bitcast i64 %59 to <2 x i32>
  %67 = bitcast <2 x i32> %66 to x86_mmx
  %68 = tail call x86_mmx @llvm.x86.mmx.pcmpeq.d(x86_mmx %67, x86_mmx bitcast (<2 x i32> zeroinitializer to x86_mmx)) #2
  %69 = bitcast x86_mmx %68 to <2 x i32>
  %70 = bitcast <2 x i32> %69 to <1 x i64>
  %71 = extractelement <1 x i64> %70, i32 0
  %72 = bitcast i64 %49 to <2 x float>
  %73 = shufflevector <2 x float> %72, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %74 = bitcast i64 %55 to <2 x float>
  %75 = shufflevector <2 x float> %74, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %76 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %75, <4 x float> %73
  %77 = bitcast i64 %65 to <2 x float>
  %78 = shufflevector <2 x float> %77, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %79 = bitcast i64 %71 to <2 x float>
  %80 = shufflevector <2 x float> %79, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %81 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %80, <4 x float> %78
  %82 = bitcast <4 x float> %76 to <4 x i32>
  %83 = xor <4 x i32> %4, %82
  tail call void @llvm.x86.mmx.emms() #2
  %84 = fmul fast <4 x float> %39, <float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000>
  %85 = fmul fast <4 x float> %39, <float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000>
  %86 = fmul fast <4 x float> %39, <float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000>
  %87 = fadd fast <4 x float> %3, %84
  %88 = fadd fast <4 x float> %85, %87
  %89 = fadd fast <4 x float> %86, %88
  %90 = fmul fast <4 x float> %89, %89
  %91 = fmul fast <4 x float> %90, <float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000>
  %92 = fadd fast <4 x float> %91, <float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000>
  %93 = fmul fast <4 x float> %90, %92
  %94 = fadd fast <4 x float> %93, <float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000>
  %95 = fmul fast <4 x float> %90, %90
  %96 = fmul fast <4 x float> %95, %94
  %97 = fmul fast <4 x float> %90, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %98 = fsub fast <4 x float> %96, %97
  %99 = fadd fast <4 x float> %98, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %100 = fmul fast <4 x float> %90, <float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000>
  %101 = fadd fast <4 x float> %100, <float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000>
  %102 = fmul fast <4 x float> %90, %101
  %103 = fadd fast <4 x float> %102, <float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000>
  %104 = fmul fast <4 x float> %90, %103
  %105 = fmul fast <4 x float> %89, %104
  %106 = fadd fast <4 x float> %89, %105
  %107 = bitcast <4 x float> %81 to <4 x i32>
  %108 = bitcast <4 x float> %106 to <4 x i32>
  %109 = and <4 x i32> %107, %108
  %110 = bitcast <4 x i32> %109 to <4 x float>
  %111 = xor <4 x i32> %107, <i32 -1, i32 -1, i32 -1, i32 -1>
  %112 = bitcast <4 x float> %99 to <4 x i32>
  %113 = and <4 x i32> %112, %111
  %114 = bitcast <4 x i32> %113 to <4 x float>
  %115 = fadd fast <4 x float> %110, %114
  %116 = bitcast <4 x float> %115 to <4 x i32>
  %117 = xor <4 x i32> %116, %83
  %118 = bitcast <4 x i32> %117 to <4 x float>
  ret <4 x float> %118
}

; Function Attrs: nounwind ssp uwtable
define <4 x float> @cos_ps(<4 x float> %x) #0 {
  %1 = bitcast <4 x float> %x to <4 x i32>
  %2 = and <4 x i32> %1, <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
  %3 = bitcast <4 x i32> %2 to <4 x float>
  %4 = fmul fast <4 x float> %3, <float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000>
  %5 = shufflevector <4 x float> <float undef, float undef, float 0.000000e+00, float 0.000000e+00>, <4 x float> %4, <4 x i32> <i32 6, i32 7, i32 2, i32 3>
  %6 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %4) #2
  %7 = bitcast x86_mmx %6 to <2 x i32>
  %8 = bitcast <2 x i32> %7 to <1 x i64>
  %9 = extractelement <1 x i64> %8, i32 0
  %10 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %5) #2
  %11 = bitcast x86_mmx %10 to <2 x i32>
  %12 = bitcast <2 x i32> %11 to <1 x i64>
  %13 = extractelement <1 x i64> %12, i32 0
  %14 = bitcast i64 %9 to <2 x i32>
  %15 = bitcast <2 x i32> %14 to x86_mmx
  %16 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %15, x86_mmx bitcast (<2 x i32> <i32 1, i32 1> to x86_mmx)) #2
  %17 = bitcast x86_mmx %16 to <2 x i32>
  %18 = bitcast <2 x i32> %17 to <1 x i64>
  %19 = extractelement <1 x i64> %18, i32 0
  %20 = bitcast i64 %13 to <2 x i32>
  %21 = bitcast <2 x i32> %20 to x86_mmx
  %22 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %21, x86_mmx bitcast (<2 x i32> <i32 1, i32 1> to x86_mmx)) #2
  %23 = bitcast x86_mmx %22 to <2 x i32>
  %24 = bitcast <2 x i32> %23 to <1 x i64>
  %25 = extractelement <1 x i64> %24, i32 0
  %26 = bitcast i64 %19 to x86_mmx
  %27 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %26, x86_mmx bitcast (i64 -4294967298 to x86_mmx)) #2
  %28 = bitcast x86_mmx %27 to i64
  %29 = bitcast i64 %25 to x86_mmx
  %30 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %29, x86_mmx bitcast (i64 -4294967298 to x86_mmx)) #2
  %31 = bitcast x86_mmx %30 to i64
  %32 = bitcast i64 %31 to <2 x i32>
  %33 = bitcast <2 x i32> %32 to x86_mmx
  %34 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> zeroinitializer, x86_mmx %33) #2
  %35 = shufflevector <4 x float> %34, <4 x float> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %36 = bitcast i64 %28 to <2 x i32>
  %37 = bitcast <2 x i32> %36 to x86_mmx
  %38 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> %35, x86_mmx %37) #2
  %39 = tail call x86_mmx @llvm.x86.mmx.psub.d(x86_mmx %37, x86_mmx bitcast (<2 x i32> <i32 2, i32 2> to x86_mmx)) #2
  %40 = bitcast x86_mmx %39 to <2 x i32>
  %41 = bitcast <2 x i32> %40 to <1 x i64>
  %42 = extractelement <1 x i64> %41, i32 0
  %43 = tail call x86_mmx @llvm.x86.mmx.psub.d(x86_mmx %33, x86_mmx bitcast (<2 x i32> <i32 2, i32 2> to x86_mmx)) #2
  %44 = bitcast x86_mmx %43 to <2 x i32>
  %45 = bitcast <2 x i32> %44 to <1 x i64>
  %46 = extractelement <1 x i64> %45, i32 0
  %47 = bitcast i64 %42 to x86_mmx
  %48 = tail call x86_mmx @llvm.x86.mmx.pandn(x86_mmx %47, x86_mmx bitcast (<1 x i64> <i64 17179869188> to x86_mmx)) #2
  %49 = bitcast x86_mmx %48 to i64
  %50 = bitcast i64 %46 to x86_mmx
  %51 = tail call x86_mmx @llvm.x86.mmx.pandn(x86_mmx %50, x86_mmx bitcast (<1 x i64> <i64 17179869188> to x86_mmx)) #2
  %52 = bitcast x86_mmx %51 to i64
  %53 = bitcast i64 %49 to <2 x i32>
  %54 = bitcast <2 x i32> %53 to x86_mmx
  %55 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %54, i32 29) #2
  %56 = bitcast x86_mmx %55 to <2 x i32>
  %57 = bitcast <2 x i32> %56 to <1 x i64>
  %58 = extractelement <1 x i64> %57, i32 0
  %59 = bitcast i64 %52 to <2 x i32>
  %60 = bitcast <2 x i32> %59 to x86_mmx
  %61 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %60, i32 29) #2
  %62 = bitcast x86_mmx %61 to <2 x i32>
  %63 = bitcast <2 x i32> %62 to <1 x i64>
  %64 = extractelement <1 x i64> %63, i32 0
  %65 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %47, x86_mmx bitcast (i64 8589934594 to x86_mmx)) #2
  %66 = bitcast x86_mmx %65 to i64
  %67 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %50, x86_mmx bitcast (i64 8589934594 to x86_mmx)) #2
  %68 = bitcast x86_mmx %67 to i64
  %69 = bitcast i64 %66 to <2 x i32>
  %70 = bitcast <2 x i32> %69 to x86_mmx
  %71 = tail call x86_mmx @llvm.x86.mmx.pcmpeq.d(x86_mmx %70, x86_mmx bitcast (<2 x i32> zeroinitializer to x86_mmx)) #2
  %72 = bitcast x86_mmx %71 to <2 x i32>
  %73 = bitcast <2 x i32> %72 to <1 x i64>
  %74 = extractelement <1 x i64> %73, i32 0
  %75 = bitcast i64 %68 to <2 x i32>
  %76 = bitcast <2 x i32> %75 to x86_mmx
  %77 = tail call x86_mmx @llvm.x86.mmx.pcmpeq.d(x86_mmx %76, x86_mmx bitcast (<2 x i32> zeroinitializer to x86_mmx)) #2
  %78 = bitcast x86_mmx %77 to <2 x i32>
  %79 = bitcast <2 x i32> %78 to <1 x i64>
  %80 = extractelement <1 x i64> %79, i32 0
  %81 = bitcast i64 %58 to <2 x float>
  %82 = shufflevector <2 x float> %81, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %83 = bitcast i64 %64 to <2 x float>
  %84 = shufflevector <2 x float> %83, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %85 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %84, <4 x float> %82
  %86 = bitcast i64 %74 to <2 x float>
  %87 = shufflevector <2 x float> %86, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %88 = bitcast i64 %80 to <2 x float>
  %89 = shufflevector <2 x float> %88, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %90 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %89, <4 x float> %87
  tail call void @llvm.x86.mmx.emms() #2
  %91 = fmul fast <4 x float> %38, <float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000>
  %92 = fmul fast <4 x float> %38, <float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000>
  %93 = fmul fast <4 x float> %38, <float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000>
  %94 = fadd fast <4 x float> %3, %91
  %95 = fadd fast <4 x float> %92, %94
  %96 = fadd fast <4 x float> %93, %95
  %97 = fmul fast <4 x float> %96, %96
  %98 = fmul fast <4 x float> %97, <float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000>
  %99 = fadd fast <4 x float> %98, <float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000>
  %100 = fmul fast <4 x float> %97, %99
  %101 = fadd fast <4 x float> %100, <float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000>
  %102 = fmul fast <4 x float> %97, %97
  %103 = fmul fast <4 x float> %102, %101
  %104 = fmul fast <4 x float> %97, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %105 = fsub fast <4 x float> %103, %104
  %106 = fadd fast <4 x float> %105, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %107 = fmul fast <4 x float> %97, <float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000>
  %108 = fadd fast <4 x float> %107, <float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000>
  %109 = fmul fast <4 x float> %97, %108
  %110 = fadd fast <4 x float> %109, <float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000>
  %111 = fmul fast <4 x float> %97, %110
  %112 = fmul fast <4 x float> %96, %111
  %113 = fadd fast <4 x float> %96, %112
  %114 = bitcast <4 x float> %90 to <4 x i32>
  %115 = bitcast <4 x float> %113 to <4 x i32>
  %116 = and <4 x i32> %114, %115
  %117 = bitcast <4 x i32> %116 to <4 x float>
  %118 = xor <4 x i32> %114, <i32 -1, i32 -1, i32 -1, i32 -1>
  %119 = bitcast <4 x float> %106 to <4 x i32>
  %120 = and <4 x i32> %119, %118
  %121 = bitcast <4 x i32> %120 to <4 x float>
  %122 = fadd fast <4 x float> %117, %121
  %123 = bitcast <4 x float> %122 to <4 x i32>
  %124 = bitcast <4 x float> %85 to <4 x i32>
  %125 = xor <4 x i32> %123, %124
  %126 = bitcast <4 x i32> %125 to <4 x float>
  ret <4 x float> %126
}

; Function Attrs: nounwind ssp uwtable
define void @sincos_ps(<4 x float> %x, <4 x float>* nocapture %s, <4 x float>* nocapture %c) #0 {
  %1 = bitcast <4 x float> %x to <4 x i32>
  %2 = and <4 x i32> %1, <i32 2147483647, i32 2147483647, i32 2147483647, i32 2147483647>
  %3 = bitcast <4 x i32> %2 to <4 x float>
  %4 = and <4 x i32> %1, <i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648>
  %5 = fmul fast <4 x float> %3, <float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000, float 0x3FF45F3060000000>
  %6 = shufflevector <4 x float> <float undef, float undef, float 0.000000e+00, float 0.000000e+00>, <4 x float> %5, <4 x i32> <i32 6, i32 7, i32 2, i32 3>
  %7 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %5) #2
  %8 = bitcast x86_mmx %7 to <2 x i32>
  %9 = bitcast <2 x i32> %8 to <1 x i64>
  %10 = extractelement <1 x i64> %9, i32 0
  %11 = tail call x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float> %6) #2
  %12 = bitcast x86_mmx %11 to <2 x i32>
  %13 = bitcast <2 x i32> %12 to <1 x i64>
  %14 = extractelement <1 x i64> %13, i32 0
  %15 = bitcast i64 %10 to <2 x i32>
  %16 = bitcast <2 x i32> %15 to x86_mmx
  %17 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %16, x86_mmx bitcast (<2 x i32> <i32 1, i32 1> to x86_mmx)) #2
  %18 = bitcast x86_mmx %17 to <2 x i32>
  %19 = bitcast <2 x i32> %18 to <1 x i64>
  %20 = extractelement <1 x i64> %19, i32 0
  %21 = bitcast i64 %14 to <2 x i32>
  %22 = bitcast <2 x i32> %21 to x86_mmx
  %23 = tail call x86_mmx @llvm.x86.mmx.padd.d(x86_mmx %22, x86_mmx bitcast (<2 x i32> <i32 1, i32 1> to x86_mmx)) #2
  %24 = bitcast x86_mmx %23 to <2 x i32>
  %25 = bitcast <2 x i32> %24 to <1 x i64>
  %26 = extractelement <1 x i64> %25, i32 0
  %27 = bitcast i64 %20 to x86_mmx
  %28 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %27, x86_mmx bitcast (i64 -4294967298 to x86_mmx)) #2
  %29 = bitcast x86_mmx %28 to i64
  %30 = bitcast i64 %26 to x86_mmx
  %31 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %30, x86_mmx bitcast (i64 -4294967298 to x86_mmx)) #2
  %32 = bitcast x86_mmx %31 to i64
  %33 = bitcast i64 %32 to <2 x i32>
  %34 = bitcast <2 x i32> %33 to x86_mmx
  %35 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> zeroinitializer, x86_mmx %34) #2
  %36 = shufflevector <4 x float> %35, <4 x float> undef, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
  %37 = bitcast i64 %29 to <2 x i32>
  %38 = bitcast <2 x i32> %37 to x86_mmx
  %39 = tail call <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float> %36, x86_mmx %38) #2
  %40 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %28, x86_mmx bitcast (i64 17179869188 to x86_mmx)) #2
  %41 = bitcast x86_mmx %40 to i64
  %42 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %31, x86_mmx bitcast (i64 17179869188 to x86_mmx)) #2
  %43 = bitcast x86_mmx %42 to i64
  %44 = bitcast i64 %41 to <2 x i32>
  %45 = bitcast <2 x i32> %44 to x86_mmx
  %46 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %45, i32 29) #2
  %47 = bitcast x86_mmx %46 to <2 x i32>
  %48 = bitcast <2 x i32> %47 to <1 x i64>
  %49 = extractelement <1 x i64> %48, i32 0
  %50 = bitcast i64 %43 to <2 x i32>
  %51 = bitcast <2 x i32> %50 to x86_mmx
  %52 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %51, i32 29) #2
  %53 = bitcast x86_mmx %52 to <2 x i32>
  %54 = bitcast <2 x i32> %53 to <1 x i64>
  %55 = extractelement <1 x i64> %54, i32 0
  %56 = bitcast i64 %49 to <2 x float>
  %57 = shufflevector <2 x float> %56, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %58 = bitcast i64 %55 to <2 x float>
  %59 = shufflevector <2 x float> %58, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %60 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %59, <4 x float> %57
  %61 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %28, x86_mmx bitcast (i64 8589934594 to x86_mmx)) #2
  %62 = bitcast x86_mmx %61 to i64
  %63 = tail call x86_mmx @llvm.x86.mmx.pand(x86_mmx %31, x86_mmx bitcast (i64 8589934594 to x86_mmx)) #2
  %64 = bitcast x86_mmx %63 to i64
  %65 = bitcast i64 %62 to <2 x i32>
  %66 = bitcast <2 x i32> %65 to x86_mmx
  %67 = tail call x86_mmx @llvm.x86.mmx.pcmpeq.d(x86_mmx %66, x86_mmx bitcast (<2 x i32> zeroinitializer to x86_mmx)) #2
  %68 = bitcast x86_mmx %67 to <2 x i32>
  %69 = bitcast <2 x i32> %68 to <1 x i64>
  %70 = extractelement <1 x i64> %69, i32 0
  %71 = bitcast i64 %64 to <2 x i32>
  %72 = bitcast <2 x i32> %71 to x86_mmx
  %73 = tail call x86_mmx @llvm.x86.mmx.pcmpeq.d(x86_mmx %72, x86_mmx bitcast (<2 x i32> zeroinitializer to x86_mmx)) #2
  %74 = bitcast x86_mmx %73 to <2 x i32>
  %75 = bitcast <2 x i32> %74 to <1 x i64>
  %76 = extractelement <1 x i64> %75, i32 0
  %77 = bitcast i64 %70 to <2 x float>
  %78 = shufflevector <2 x float> %77, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %79 = bitcast i64 %76 to <2 x float>
  %80 = shufflevector <2 x float> %79, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %81 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %80, <4 x float> %78
  %82 = fmul fast <4 x float> %39, <float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000, float 0xBFE9200000000000>
  %83 = fmul fast <4 x float> %39, <float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000, float 0xBF2FB40000000000>
  %84 = fmul fast <4 x float> %39, <float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000, float 0xBE64442D20000000>
  %85 = fadd fast <4 x float> %3, %82
  %86 = fadd fast <4 x float> %83, %85
  %87 = fadd fast <4 x float> %84, %86
  %88 = tail call x86_mmx @llvm.x86.mmx.psub.d(x86_mmx %38, x86_mmx bitcast (<2 x i32> <i32 2, i32 2> to x86_mmx)) #2
  %89 = bitcast x86_mmx %88 to <2 x i32>
  %90 = bitcast <2 x i32> %89 to <1 x i64>
  %91 = extractelement <1 x i64> %90, i32 0
  %92 = tail call x86_mmx @llvm.x86.mmx.psub.d(x86_mmx %34, x86_mmx bitcast (<2 x i32> <i32 2, i32 2> to x86_mmx)) #2
  %93 = bitcast x86_mmx %92 to <2 x i32>
  %94 = bitcast <2 x i32> %93 to <1 x i64>
  %95 = extractelement <1 x i64> %94, i32 0
  %96 = bitcast i64 %91 to x86_mmx
  %97 = tail call x86_mmx @llvm.x86.mmx.pandn(x86_mmx %96, x86_mmx bitcast (<1 x i64> <i64 17179869188> to x86_mmx)) #2
  %98 = bitcast x86_mmx %97 to i64
  %99 = bitcast i64 %95 to x86_mmx
  %100 = tail call x86_mmx @llvm.x86.mmx.pandn(x86_mmx %99, x86_mmx bitcast (<1 x i64> <i64 17179869188> to x86_mmx)) #2
  %101 = bitcast x86_mmx %100 to i64
  %102 = bitcast i64 %98 to <2 x i32>
  %103 = bitcast <2 x i32> %102 to x86_mmx
  %104 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %103, i32 29) #2
  %105 = bitcast x86_mmx %104 to <2 x i32>
  %106 = bitcast <2 x i32> %105 to <1 x i64>
  %107 = extractelement <1 x i64> %106, i32 0
  %108 = bitcast i64 %101 to <2 x i32>
  %109 = bitcast <2 x i32> %108 to x86_mmx
  %110 = tail call x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx %109, i32 29) #2
  %111 = bitcast x86_mmx %110 to <2 x i32>
  %112 = bitcast <2 x i32> %111 to <1 x i64>
  %113 = extractelement <1 x i64> %112, i32 0
  %114 = bitcast i64 %107 to <2 x float>
  %115 = shufflevector <2 x float> %114, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  %116 = bitcast i64 %113 to <2 x float>
  %117 = shufflevector <2 x float> %116, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  %118 = select <4 x i1> <i1 false, i1 false, i1 true, i1 true>, <4 x float> %117, <4 x float> %115
  tail call void @llvm.x86.mmx.emms() #2
  %119 = bitcast <4 x float> %60 to <4 x i32>
  %120 = xor <4 x i32> %4, %119
  %121 = fmul fast <4 x float> %87, %87
  %122 = fmul fast <4 x float> %121, <float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000, float 0x3EF99EB9C0000000>
  %123 = fadd fast <4 x float> %122, <float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000, float 0xBF56C0C340000000>
  %124 = fmul fast <4 x float> %121, %123
  %125 = fadd fast <4 x float> %124, <float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000, float 0x3FA55554A0000000>
  %126 = fmul fast <4 x float> %121, %121
  %127 = fmul fast <4 x float> %126, %125
  %128 = fmul fast <4 x float> %121, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %129 = fsub fast <4 x float> %127, %128
  %130 = fadd fast <4 x float> %129, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %131 = fmul fast <4 x float> %121, <float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000, float 0xBF29943F20000000>
  %132 = fadd fast <4 x float> %131, <float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000, float 0x3F811073C0000000>
  %133 = fmul fast <4 x float> %121, %132
  %134 = fadd fast <4 x float> %133, <float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000, float 0xBFC5555460000000>
  %135 = fmul fast <4 x float> %121, %134
  %136 = fmul fast <4 x float> %87, %135
  %137 = fadd fast <4 x float> %87, %136
  %138 = bitcast <4 x float> %81 to <4 x i32>
  %139 = bitcast <4 x float> %137 to <4 x i32>
  %140 = and <4 x i32> %138, %139
  %141 = bitcast <4 x i32> %140 to <4 x float>
  %142 = xor <4 x i32> %138, <i32 -1, i32 -1, i32 -1, i32 -1>
  %143 = bitcast <4 x float> %130 to <4 x i32>
  %144 = and <4 x i32> %143, %142
  %145 = bitcast <4 x i32> %144 to <4 x float>
  %146 = fsub fast <4 x float> %137, %141
  %147 = fsub fast <4 x float> %130, %145
  %148 = fadd fast <4 x float> %141, %145
  %149 = fadd fast <4 x float> %146, %147
  %150 = bitcast <4 x float> %148 to <4 x i32>
  %151 = xor <4 x i32> %150, %120
  %152 = bitcast <4 x i32> %151 to <4 x float>
  store <4 x float> %152, <4 x float>* %s, align 16
  %153 = bitcast <4 x float> %149 to <4 x i32>
  %154 = bitcast <4 x float> %118 to <4 x i32>
  %155 = xor <4 x i32> %153, %154
  %156 = bitcast <4 x i32> %155 to <4 x float>
  store <4 x float> %156, <4 x float>* %c, align 16
  ret void
}

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.mmx.pandn(x86_mmx, x86_mmx) #1

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.mmx.pcmpeq.d(x86_mmx, x86_mmx) #1

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.mmx.pand(x86_mmx, x86_mmx) #1

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.mmx.pslli.d(x86_mmx, i32) #1

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.mmx.padd.d(x86_mmx, x86_mmx) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.cmp.ps(<4 x float>, <4 x float>, i8) #1

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.sse.cvttps2pi(<4 x float>) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.min.ps(<4 x float>, <4 x float>) #1

; Function Attrs: nounwind
declare void @llvm.x86.mmx.emms() #2

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.cvtpi2ps(<4 x float>, x86_mmx) #1

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.mmx.psub.d(x86_mmx, x86_mmx) #1

; Function Attrs: nounwind readnone
declare x86_mmx @llvm.x86.mmx.psrli.d(x86_mmx, i32) #1

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.x86.sse.max.ps(<4 x float>, <4 x float>) #1
