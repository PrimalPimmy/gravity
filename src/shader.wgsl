struct CircleParams {
    position: vec2<f32>,
    radius: f32,
};

@group(0) @binding(0)
var<uniform> params: CircleParams;

// the data passed from the Vertex stage to the Fragment stage
struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec3<f32>,
};

@vertex
fn vs_main(
    @builtin(vertex_index) item_index: u32,
) -> VertexOutput {
    var out: VertexOutput;
    
    let pi = 3.14159265359;
    let total_segments = 100u; 

    // logic to simulate GL_TRIANGLE_FAN using a Triangle List like OpenGL
    let tri_index = item_index / 3u;
    let vert_in_tri = item_index % 3u;

    var pos = vec2<f32>(0.0, 0.0);

    if (vert_in_tri == 0u) {
        // the center of the circle
        pos = params.position;
    } else if (vert_in_tri == 1u) {
        // the start of this wedge's arc
        let angle = f32(tri_index) * 2.0 * pi / f32(total_segments);
        pos = vec2<f32>(
            cos(angle) * params.radius,
            sin(angle) * params.radius
        ) + params.position;
    } else {
        // the end of this wedge's arc
        let angle = f32(tri_index + 1u) * 2.0 * pi / f32(total_segments);
        pos = vec2<f32>(
            cos(angle) * params.radius,
            sin(angle) * params.radius
        ) + params.position;
    }

    out.clip_position = vec4<f32>(pos, 0.0, 1.0);
    

    out.color = vec3<f32>(1.0, 0.0, 0.0);
    
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(in.color, 1.0);
}