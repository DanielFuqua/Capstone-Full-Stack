import React from "react";
import { Card, CardImg, CardBody, CardTitle, CardSubtitle } from "reactstrap";


const Pose = ({ pose }) => {

    console.log(pose);

    return (

        <Card >
            <CardImg width="200px" src={pose.imageLocation} alt={pose.nameEnglish} />

            <CardBody>
                <CardTitle>{pose.nameEnglish}</CardTitle>
                <CardSubtitle>{pose.nameSanskrit}</CardSubtitle>
            </CardBody>

        </Card>
    )
};

export default Pose;