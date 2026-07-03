const clients = [
  'Niger Delta Development Corporation (NDDC)',
  'Rivers State Ministry of Power',
  'Rivers State Sustainable Development & Monitoring Board (RSSDA)',
  'Nigerian Content Development and Monitoring Board (NCDMB)',
  'Shell Petroleum Development Company (SPDC)',
  'Nigeria Liquefied Natural Gas (NLNG)',
  'Rivers State Ministry of Works',
  'Rivers State Ministry of Employment Generation and Empowerment',
  'Rivers State Ministry of Youth Development',
  'Local Government Councils',
  'Non-Governmental Organizations (NGOs)',
  'Corporate Organisations and Private Sector Partners'
]

function Clients() {
  return (
    <section className="section-block" id="clients">
      <div className="section-header">
        <span className="eyebrow">Our Clients</span>
        <h2>Trusted by government agencies, NGOs, and industry partners</h2>
      </div>
      <div className="client-grid">
        {clients.map((client) => (
          <article className="client-card" key={client}>
            <h3>{client}</h3>
          </article>
        ))}
      </div>
    </section>
  )
}

export default Clients
