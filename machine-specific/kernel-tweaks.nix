# Sophie: I don't remember where it's mostly taken from.
# Anyway, you probably should not run this kernel on your main machine,
# unless you are a latency maniac and want to squeeze out those few ms

{ lib, ... }:

{
  boot = {
    kernelPatches = [
      {
        name = "meowmeowmewmrreow";
        patch = null;
        structuredExtraConfig = with lib.kernel; {
          CPU_FREQ_DEFAULT_GOV_PERFORMANCE = lib.mkOverride 60 yes;
          CPU_FREQ_DEFAULT_GOV_SCHEDUTIL = lib.mkOverride 60 no;

          PREEMPT = lib.mkForce yes;
          EXPERT = lib.mkOverride 100 yes;
          PREEMPT_RT = lib.mkOverride 100 yes;
          RT_GROUP_SCHED = lib.mkForce (option no);

          DRM_I915_GVT = lib.mkForce unset;
          DRM_I915_GVT_KVMGT = lib.mkForce unset;
          PREEMPT_VOLUNTARY = lib.mkForce unset;

          # Google's BBRv3 TCP congestion Control
          TCP_CONG_BBR = yes;
          DEFAULT_BBR = yes;

          # Preemptive tickless idle kernel
          HZ = freeform "1000";
          HZ_1000 = yes;
          NO_HZ = no;
          NO_HZ_FULL = lib.mkOverride 60 no;
          NO_HZ_IDLE = yes;
        };
      }
    ];
  };
}
