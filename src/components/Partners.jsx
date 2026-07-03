const partners = [
  {
    name: 'Advance Fabrication Ltd.',
    details: '#280 Trans Amadi Road, by Nipost Building'
  },
  {
    name: 'Bie – Usha (W/A) Ltd.',
    details: 'Plot 201B PHC/Aba Express Road, Rumuola Junction, P.H.'
  },
  {
    name: 'Globspec Engineering and Trading Ltd.',
    details: 'No. 52 Igboukwu Street, D-line, P.H.'
  },
  {
    name: 'Professional Workshop Partners',
    details: 'Local workshops providing practical placements and hands-on training.'
  },
  {
    name: 'Certification Bodies',
    details: 'National and industry certification partners for training credentials.'
  }
]

function Partners() {
  return (
    <section className="section-block" id="partners">
      <div className="section-header">
        <span className="eyebrow">Our Partners and Allies</span>
        <h2>Collaborating with professional workshops, certification bodies, and industry stakeholders</h2>
      </div>
      <div className="partner-grid">
        {partners.map((partner) => (
          <article className="partner-card" key={partner.name}>
            <h3>{partner.name}</h3>
            <p>{partner.details}</p>
          </article>
        ))}
      </div>
    </section>
  )
}

export default Partners
