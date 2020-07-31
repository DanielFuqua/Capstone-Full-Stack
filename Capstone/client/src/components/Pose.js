import React from "react";
import { Card, CardImg, CardBody, CardTitle, CardSubtitle } from "reactstrap";

const Pose = ({ pose }) => {

    return (
        <Card className="text-center">
            <CardImg src={pose.imageLocation} alt={pose.nameEnglish} />
            <CardBody>
                <CardTitle>{pose.nameEnglish}</CardTitle>
            </CardBody>
        </Card>
    )
};

export default Pose;