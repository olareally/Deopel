const impactItems = [
  {
    title: 'Trained & Employed',
    description:
      'Many of our trainees have gone on to secure full-time employment in industry and service roles.'
  },
  {
    title: 'Entrepreneurship & Self-Employment',
    description:
      'Graduates start businesses, become independent service providers, and create jobs by taking on apprentices.'
  },
  {
    title: 'Practical Placement',
    description:
      'We partner with professional workshops and industry partners to provide hands-on placement where specialised equipment is needed.'
  },
  {
    title: 'Industry Readiness',
    description:
      'Trainees gain skills that make them employable in oil & gas, process manufacturing, building and construction, and public sector projects.'
  }
]

function Impact() {
  return (
    <section className="section-block" id="impact">
      <div className="section-header">
        <span className="eyebrow">Our Impact</span>
        <h2>Building self-reliant professionals through practical training and placement</h2>
      </div>

      <div className="about-content">
        <p>
          Deopel has trained youths in artisanship and engineering software skills. Many of them
          have gone on to become fully employed, start businesses, or work as workshop operators
          and trainers. Through our collaborations with partner workshops, trainees receive
          practical experience and certifications that improve employability and support
          entrepreneurship.
        </p>

        <ul>
          <li>Enable trainees to become entrepreneurs and self-employed professionals.</li>
          <li>Equip trainees to employ others and mentor apprentices, growing local workforces.</li>
          <li>Provide practical placements and certification pathways with partner organisations.</li>
          <li>Prepare trainees for roles in oil & gas, manufacturing, and building industries.</li>
        </ul>

        <p>
          These outcomes reduce unemployment and increase resilience in the communities we serve.
        </p>
      </div>

      <div className="stat-grid">
        {impactItems.map((item) => (
          <article className="stat-card" key={item.title}>
            <h3>{item.title}</h3>
            <p>{item.description}</p>
          </article>
        ))}
      </div>
    </section>
  )
}

export default Impact
