include "../node_modules/circomlib/circuits/eddsamimc.circom";
include "../node_modules/circomlib/circuits/mimc.circom";

template VerifyEdDSAMiMC(k) {
    signal input from_x;
    signal input from_y;
    signal input R8x;
    signal input R8y;
    signal input S;
    signal private input preimage[k];
    
    component M = MultiMiMC7(k, 91);
    M.k <== k;
    for (var i = 0; i < k; i++){
        M.in[i] <== preimage[i];
    }
    
    component verifier = EdDSAMiMCVerifier();

    verifier.enabled <== 0;
    verifier.Ax <== from_x;
    verifier.Ay <== from_y;
    verifier.R8x <== R8x;
    verifier.R8y <== R8y;
    verifier.S <== S;
    verifier.M <== M.out;
}