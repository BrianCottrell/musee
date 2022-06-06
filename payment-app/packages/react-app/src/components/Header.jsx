import React from "react";
import { Typography } from "antd";

const { Title, Text } = Typography;

// displays a page header

export default function Header({ link, title, subTitle, ...props }) {
  return (
    <div style={{ display: "flex", justifyContent: "space-between", padding: "1.2rem" }}>
      <div style={{ display: "flex",  flexDirection: "column", flex: 1, alignItems: "center", marginLeft: 350 }}>
        <a href={'https://xd.adobe.com/view/816b660f-44d0-496e-b516-e63fbe322a2e-d438/screen/04017962-f5b9-451b-90f5-55f84b9e0f3e?fullscreen&hints=off'} target="_blank" rel="noopener noreferrer">
          <img src={'https://res.cloudinary.com/ideation/image/upload/w_128,h_128,q_auto,f_auto,dpr_auto/irvvs0ozhnewcecly5ic'} />
        </a>
        <Text type="secondary" style={{ textAlign: "center" }}>{subTitle}</Text>
      </div>
      {props.children}
    </div>
  );
}

Header.defaultProps = {
  link: "https://platform.zencon.bemyapp.com/#/projects/629cd083494b7c002d1f5e21",
  title: "Musee",
  subTitle: "Maximizing the work efficency and ganancies to every musician in the world",
};
