// Convert extracted features from IRGraph to IRSchema numeric representation.
//W.I.P, Hopefully finish tomorrow.
#[derive(Debug, Default, Clone, Serialize, Deserialize)]
pub struct IRSchema {
    pub instruction: InstructionFeatures,
    pub ssa: SSAFeatures,
    pub cfg: CFGFeatures,
    pub loop_: LoopFeatures,
    pub lcssa: LCSSAFeatures,
}
